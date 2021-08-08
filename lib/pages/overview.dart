import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../pages/new_balance_item.dart';
import '../widgets/balance_item.dart';
import '../widgets/transition_widget.dart';

class BalanceItemList extends StatelessWidget {
  const BalanceItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeString = Localizations.localeOf(context).toLanguageTag();
    // TODO use animatedlistview
    return ListView(
      padding: EdgeInsets.only(left: 8, right: 8),
      children: <Widget>[
        HeadingItem(heading: AppLocalizations.of(context)!.expensesHeader),
        Consumer<BalanceItemListModel>(
          builder: (context, model, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var expense in model.expenseList)
                BalanceItemCard(
                  balanceItem: expense,
                  localeString: localeString,
                ),
            ],
          ),
        ),
        HeadingItem(heading: AppLocalizations.of(context)!.incomeHeader),
        Consumer<BalanceItemListModel>(
          builder: (context, model, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var income in model.incomeList)
                BalanceItemCard(
                  balanceItem: income,
                  localeString: localeString,
                ),
              // TODO add total money
            ],
          ),
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
        actions: <Widget>[
          PopupMenuButton<SortingMethod>(
            icon: Icon(Icons.sort),
            tooltip: AppLocalizations.of(context)!.sortButtonDescription,
            onSelected: (SortingMethod result) {
              Provider.of<BalanceItemListModel>(context, listen: false)
                  .sortBy(result);
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<SortingMethod>>[
              PopupMenuItem<SortingMethod>(
                value: SortingMethod.name,
                child: Text(AppLocalizations.of(context)!.sortByName),
              ),
              PopupMenuItem<SortingMethod>(
                value: SortingMethod.price,
                child: Text(AppLocalizations.of(context)!.sortByPrice),
              ),
            ],
          )
        ],
      ),
      body: Scrollbar(
        child: BalanceItemList(),
      ),
      floatingActionButton: CreateNewBalanceItemCardFAB(
        transitionType: transitionType,
        route: NewBalanceItemRoute(),
      ),
    );
  }
}
