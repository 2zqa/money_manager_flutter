import 'package:flutter/material.dart';

import 'pages/overview.dart';

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
      home: OverviewRoute(title: appName),
    );
  }
}
