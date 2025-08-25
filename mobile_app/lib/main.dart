import 'package:flutter/material.dart';
import 'package:mobile_app/screens/onboarding/app_onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_app/core/providers/locale_provider.dart';
import 'package:mobile_app/l10n/app_localizations.dart';
import 'package:mobile_app/screens/home/home_screen.dart';
import 'package:mobile_app/config/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_app/core/providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final firstLaunch = prefs.getBool('firstLaunch') ?? true;

  Locale deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;

  final supportedLocales = [Locale('en'), Locale('fr'), Locale('ar')];
  if (!supportedLocales.any((loc) => loc.languageCode == deviceLocale.languageCode)) {
    deviceLocale = const Locale('en');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider(deviceLocale)),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(firstLaunch: firstLaunch),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool firstLaunch;
  const MyApp({super.key, required this.firstLaunch});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>().locale;

    return MaterialApp(
      title: 'Food Delivery App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: firstLaunch ? const AppOnboardingScreen() : const HomePage(),
    );
  }
}
