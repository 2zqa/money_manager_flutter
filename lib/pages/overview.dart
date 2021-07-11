import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_flutter/pages/new_balance_item.dart';

import '../widgets/balance_item.dart';
import '../widgets/transition_widget.dart';

class OverviewRoute extends StatelessWidget {
  final transitionType = ContainerTransitionType.fade;
  final String title;

  const OverviewRoute({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          HeadingItem(heading: "Expenses"),
          BalanceItemCard(
            Expense("Spotify", 250, RecurringType.daily),
          ), // TODO: replace single card with list, add heading to list including header argument
          HeadingItem(heading: "Income"),
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
