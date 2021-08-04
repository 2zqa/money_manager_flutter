import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:money_manager_flutter/widgets/balance_item.dart';
import 'package:provider/provider.dart';

import 'pages/overview.dart';

void main() {
  //TODO check whether this is scope pollution
  runApp(ChangeNotifierProvider(
    create: (context) => BalanceItemListModel(),
    child: MoneyManagerApp(),
  ));
}

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
      home: OverviewRoute(),
    );
  }
}
