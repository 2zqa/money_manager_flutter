import 'package:flutter/material.dart';

// Logic
enum RecurringType { daily, weekly, fortnightly, monthly, yearly }

abstract class BalanceItem {
  String name;
  int cost;
  RecurringType recurringType;

  BalanceItem(this.name, this.cost, this.recurringType);
}

class Expense extends BalanceItem {
  Expense(String name, int cost, RecurringType recurringType)
      : super(name, cost, recurringType);
}

class Income extends BalanceItem {
  Income(String name, int cost, RecurringType recurringType)
      : super(name, cost, recurringType);
}

// Widgets
class HeadingItem extends StatelessWidget {
  final String heading;
  const HeadingItem({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(heading, style: Theme.of(context).textTheme.headline5);
  }
}

class BalanceItemCard extends StatelessWidget {
  final BalanceItem balanceItem;

  const BalanceItemCard(this.balanceItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
        onTap: () {
          print('Card tapped.');
        },
        child: ListTile(
          leading: Icon(
            this.balanceItem is Income
                ? Icons.arrow_upward
                : Icons.arrow_downward,
          ),
          title: Text(this.balanceItem.name),
          subtitle: Text((this.balanceItem.cost / 100).toString()),
        ),
      ),
    );
  }
}
