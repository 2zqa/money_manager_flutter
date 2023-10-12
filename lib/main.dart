import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'pages/overview.dart';
import 'widgets/balance_item.dart';

/// Runs the app and creates a [ChangeNotifierProvider], used to manage balance items.
///
/// See also:
/// * [BalanceItemList]
void main() {
  runApp(ChangeNotifierProvider<BalanceItemListModel>(
    create: (BuildContext context) => BalanceItemListModel(),
    child: const MoneyManagerApp(),
  ));
}

/// The main widget that gets run from [main].
class MoneyManagerApp extends StatelessWidget {
  const MoneyManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.title,
      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const OverviewRoute(),
    );
  }
}
