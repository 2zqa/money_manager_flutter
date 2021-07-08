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
          children: <Widget>[Text("test1"), Text("test2")],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}
