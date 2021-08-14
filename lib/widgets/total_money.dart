import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'balance_item.dart';

class TotalMoney extends StatelessWidget {
  const TotalMoney({Key? key}) : super(key: key);

  String _formatMoney(String localeString, int cents) =>
      NumberFormat.simpleCurrency(locale: localeString).format(cents / 100);

  @override
  Widget build(BuildContext context) {
    final String localeString = Localizations.localeOf(context).toLanguageTag();

    return Consumer<BalanceItemListModel>(
      builder: (BuildContext context, BalanceItemListModel model, _) => ListTile(
        leading: Icon(model.isNetPositive ? Icons.arrow_upward : Icons.arrow_downward),
        title: Text(_formatMoney(localeString, model.totalPrice)),
      )
    );
  }
}
