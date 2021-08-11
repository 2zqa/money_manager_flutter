import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'pages/overview.dart';
import 'widgets/balance_item.dart';

void main() {
  runApp(ChangeNotifierProvider<BalanceItemListModel>(
    create: (BuildContext context) => BalanceItemListModel(),
    child: MoneyManagerApp(),
  ));
}

/// The main widget that gets run from [main].
class MoneyManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.title,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const OverviewRoute(),
    );
  }
}
