import 'package:flutter/material.dart';
import 'package:mobile_app/screens/home/home_screen.dart';
import '../config/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_app/l10n/app_localizations.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      theme: AppTheme.lightTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
        Locale('ar'),
      ],
      locale: const Locale('fr'), // ou Locale('en') selon tes tests
      home: const HomePage(),
    );
  }
}

