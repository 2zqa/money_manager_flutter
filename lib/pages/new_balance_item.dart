import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/balance_item.dart';

class NewBalanceItemForm extends StatefulWidget {
  const NewBalanceItemForm({super.key});

  @override
  NewBalanceItemFormState createState() {
    return NewBalanceItemFormState();
  }
}

class NewBalanceItemFormState extends State<NewBalanceItemForm> {
  bool _isExpense = false;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  String _getCurrency(String locale) =>
      NumberFormat.compactSimpleCurrency(locale: locale).currencyName ?? '';

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? al = AppLocalizations.of(context);
    final String languageTag = Localizations.localeOf(context).toLanguageTag();
    final NumberFormat formatter =
        NumberFormat.currency(decimalDigits: 2, locale: languageTag);
    final NumberFormat placeholderFormatter =
        NumberFormat('#,##0.00', languageTag);
    // Use wrap so spacing is available
    return Form(
      key: _formKey,
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: <Widget>[
          // Name
          TextFormField(
            controller: nameController,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return al.requiredFieldError;
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: '${al!.balanceItemName}*',
              hintText: al.expenseItemNamePlaceholder,
              filled: true,
              border: const UnderlineInputBorder(),
            ),
          ),
          // Amount
          TextFormField(
            controller: amountController,
            validator: (String? value) {
              // Null check
              if (value == null || value.isEmpty) {
                return al.requiredFieldError;
              }

              // Parse check
              try {
                formatter.parse(value);
              } on FormatException {
                return al.balanceItemAmountError;
              }

              // Passed all checks, return null
              return null;
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: '${AppLocalizations.of(context)!.balanceItemAmount}*',
              hintText: placeholderFormatter.format(0),
              filled: true,
              border: const UnderlineInputBorder(),
              suffixText:
                  _getCurrency(Localizations.localeOf(context).toLanguageTag()),
            ),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(AppLocalizations.of(context)!.isExpense),
            controlAffinity: ListTileControlAffinity.leading,
            value: _isExpense,
            onChanged: (bool? newValue) {
              if (newValue != null) {
                setState(() {
                  _isExpense = newValue;
                });
              }
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final String name = nameController.text.trim();
                  // Since currentstate validate is true, we know we can safely parse the amount.
                  final int amount =
                      (formatter.parse(amountController.text) * 100).toInt();

                  final BalanceItemListModel itemList =
                      Provider.of<BalanceItemListModel>(context, listen: false);

                  if (_isExpense) {
                    final Expense expense =
                        Expense(name, amount, RecurringType.daily);
                    itemList.addExpense(expense);
                  } else {
                    final Income income =
                        Income(name, amount, RecurringType.daily);
                    itemList.addIncome(income);
                  }

                  // Hide keyboard and close this route
                  FocusScope.of(context).unfocus();
                  Future<void>.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pop(context);
                  });
                }
              },
              child: Text(AppLocalizations.of(context)!.addBalanceItem),
            ),
          ),
        ],
      ),
    );
  }
}

class NewBalanceItemRoute extends StatelessWidget {
  const NewBalanceItemRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Statusbar fix: https://stackoverflow.com/questions/66511420/why-my-status-bar-icons-are-black-and-why-cant-i-change-it-after-flutter-2-0
        title: Text(AppLocalizations.of(context)!.newBalanceItemTitle),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: NewBalanceItemForm(),
      ),
    );
  }
}
