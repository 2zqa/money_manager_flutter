import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../pages/new_balance_item.dart';
import '../widgets/balance_item.dart';
import '../widgets/transition_widget.dart';

class OverviewRoute extends StatelessWidget {
  final transitionType = ContainerTransitionType.fade;

  const OverviewRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          HeadingItem(heading: AppLocalizations.of(context)!.expensesHeader),
          BalanceItemCard(
            Expense("Spotify", 250, RecurringType.daily),
          ), // TODO: replace single card with list, add heading to list including header argument
          HeadingItem(heading: AppLocalizations.of(context)!.incomeHeader),
          BalanceItemCard(Income("Salaris", 30000, RecurringType.monthly))
        ],
      ),
      floatingActionButton: CreateNewBalanceItemCardFAB(
        transitionType: transitionType,
        route: NewBalanceItemRoute(),
      ),
    );
  }
}
