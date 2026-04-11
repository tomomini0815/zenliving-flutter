import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'state/zen_state.dart';
import 'theme/app_theme.dart';
import 'screens/entry_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ZenState(),
      child: const ZenLivingApp(),
    ),
  );
}

class ZenLivingApp extends StatelessWidget {
  const ZenLivingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<ZenState>().locale;
    return MaterialApp(
      title: 'ZenLiving',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const EntryScreen(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
