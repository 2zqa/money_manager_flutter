import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class NewBalanceItemForm extends StatefulWidget {
  @override
  NewBalanceItemFormState createState() {
    return NewBalanceItemFormState();
  }
}

class NewBalanceItemFormState extends State<NewBalanceItemForm> {
  bool _isExpense = false;

  final _formKey = GlobalKey<FormState>();

  String _getCurrency(String locale) =>
      NumberFormat.compactSimpleCurrency(locale: locale).currencyName ?? "";

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? al = AppLocalizations.of(context);
    final String languageTag = Localizations.localeOf(context).toLanguageTag();
    final formatter =
        NumberFormat.currency(decimalDigits: 2, locale: languageTag);
    NumberFormat placeholderFormatter = NumberFormat("#,##0.00", languageTag);
    // Use wrap so spacing is available
    return Form(
      key: _formKey,
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: <Widget>[
          // Name
          TextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return al!.requiredFieldError;
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: al!.balanceItemName + "*",
              hintText: al.expenseItemNamePlaceholder,
              filled: true,
              border: UnderlineInputBorder(),
            ),
          ),
          // Amount
          TextFormField(
            validator: (value) {
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
              labelText: AppLocalizations.of(context)!.balanceItemAmount + "*",
              hintText: placeholderFormatter.format(0),
              filled: true,
              border: UnderlineInputBorder(),
              suffixText:
                  _getCurrency(Localizations.localeOf(context).toLanguageTag()),
            ),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(AppLocalizations.of(context)!.isExpense),
            controlAffinity: ListTileControlAffinity.leading,
            value: _isExpense,
            onChanged: (newValue) {
              if (newValue != null) {
                // TODO: check of bool? == bool
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
                  print("Done!");
                  Navigator.pop(context);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Statusbar fix: https://stackoverflow.com/questions/66511420/why-my-status-bar-icons-are-black-and-why-cant-i-change-it-after-flutter-2-0
        brightness: Brightness.dark,
        title: Text(AppLocalizations.of(context)!.newBalanceItemTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: NewBalanceItemForm(),
      ),
    );
  }
}
