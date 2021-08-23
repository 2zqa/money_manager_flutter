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
    child: MoneyManagerApp(),
  ));
}

/// The main widget that gets run from [main].
class MoneyManagerApp extends StatelessWidget {
  /// Creates a swatch from a [color]. The primary color shade can be defined
  /// with [primaryShade], which should be a [MaterialColor] shade (for example: 200)
  MaterialColor swatchify(MaterialColor color, {int primaryShade = 500}) {
    return MaterialColor(color[primaryShade]!.value, <int, Color>{
      50: color[50]!,
      100: color[100]!,
      200: color[200]!,
      300: color[300]!,
      400: color[400]!,
      500: color[500]!,
      600: color[600]!,
      700: color[700]!,
      800: color[800]!,
      900: color[900]!,
    });
  }

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
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: swatchify(Colors.green, primaryShade: 200),
        accentColor: Colors.green.shade200,
      ),
      themeMode: ThemeMode.system,
      home: const OverviewRoute(),
    );
  }
}
