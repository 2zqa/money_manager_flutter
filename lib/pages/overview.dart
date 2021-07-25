import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../pages/new_balance_item.dart';
import '../widgets/balance_item.dart';
import '../widgets/transition_widget.dart';

class BalanceItemList extends StatelessWidget {
  final List<BalanceItem> balanceItemList;

  const BalanceItemList({Key? key, required this.balanceItemList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var balanceItem in balanceItemList)
          BalanceItemCard(
            balanceItem: balanceItem,
            localeString: Localizations.localeOf(context).toLanguageTag(),
          ),
      ],
    );
  }
}

class OverviewRoute extends StatelessWidget {
  final transitionType = ContainerTransitionType.fade;

  const OverviewRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Statusbar fix: https://stackoverflow.com/questions/66511420/why-my-status-bar-icons-are-black-and-why-cant-i-change-it-after-flutter-2-0
        brightness: Brightness.dark,
        title: Text(AppLocalizations.of(context)!.title),
      ),
      body: Scrollbar(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            HeadingItem(heading: AppLocalizations.of(context)!.expensesHeader),
            BalanceItemList(
              balanceItemList: [
                Expense("Spotify", 250, RecurringType.monthly),
                Expense("Reddit", 900, RecurringType.monthly),
                Expense("Reddit", 900, RecurringType.monthly),
                Expense("Reddit", 900, RecurringType.monthly),
                Expense("Reddit", 900, RecurringType.monthly),
              ],
            ),
            HeadingItem(heading: AppLocalizations.of(context)!.incomeHeader),
            BalanceItemList(
              balanceItemList: [
                Income("Salaris", 900001, RecurringType.monthly),
                Income("Oma", 1000, RecurringType.yearly),
                Income("Mammie", 200, RecurringType.yearly),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: CreateNewBalanceItemCardFAB(
        transitionType: transitionType,
        route: NewBalanceItemRoute(),
      ),
    );
  }
}
