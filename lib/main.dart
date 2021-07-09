import 'package:flutter/material.dart';

// Logic
enum RecurringType { daily, weekly, fortnightly, monthly, yearly }

class BalanceItem {
  String name;
  int cost;
  RecurringType recurringType;

  BalanceItem(this.name, this.cost, this.recurringType);
}

// App
void main() {
  runApp(MoneyManagerApp());
}

class BalanceItemCard extends StatefulWidget {
  const BalanceItemCard({Key? key}) : super(key: key);

  @override
  _BalanceItemCardState createState() => _BalanceItemCardState();
}

class _BalanceItemCardState extends State<BalanceItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album),
            title: Text('The Enchanted Nightingale'),
            subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('LISTEN'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
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
          children: <Widget>[
            HeadingItem(heading: "Expenses"),
            BalanceItemCard(), // TODO: replace single card with list, add heading to list including header argument
            HeadingItem(heading: "Income"),
            BalanceItemCard()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
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
