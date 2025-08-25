// lib/app/locale_provider.dart
import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale;

  LocaleProvider([Locale? initial]) : _locale = initial ?? const Locale('fr');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }
}
