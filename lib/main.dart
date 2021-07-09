import 'package:flutter/material.dart';
import 'new_balance_item.dart';

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

// App
void main() {
  runApp(MoneyManagerApp());
}

class BalanceItemCard extends StatelessWidget {
  final BalanceItem balanceItem;

  const BalanceItemCard(this.balanceItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
            splashColor: Theme.of(context).colorScheme.primary.withAlpha(30),
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
            )));
  }
}

class MoneyManagerApp extends StatelessWidget {
  final String appName = "Money Manager";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: OverviewPage(title: appName),
    );
  }
}

class OverviewPage extends StatelessWidget {
  final String title;

  const OverviewPage({Key? key, required this.title}) : super(key: key);

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
            BalanceItemCard(Expense(
                "Spotify",
                250,
                RecurringType
                    .daily)), // TODO: replace single card with list, add heading to list including header argument
            HeadingItem(heading: "Income"),
            BalanceItemCard(Income("Salaris", 30000, RecurringType.monthly))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute()),
            );
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}

class HeadingItem extends StatelessWidget {
  final String heading;
  const HeadingItem({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(heading, style: Theme.of(context).textTheme.headline5);
  }
}
