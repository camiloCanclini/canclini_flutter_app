import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ThemeModel {
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color cardBackgroundColor;
  final Color cardSecondaryBackgroundColor;
  final Color cardShadowColor;
  final Color bottomBarColor;

  ThemeModel({
    required this.primaryColor,
    required this.accentColor,
    required this.backgroundColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.cardBackgroundColor,
    required this.bottomBarColor,
    required this.cardSecondaryBackgroundColor,
    required this.cardShadowColor,
  });
}

class LightTheme extends ThemeModel {
  LightTheme()
      : super(
    primaryColor: const Color(0xFF8811F7),
    accentColor: const Color(0xFFC83DFF),
    backgroundColor: const Color(0xFFE6E5EA),
    primaryTextColor: Colors.black,
    secondaryTextColor: Colors.black38,
    cardBackgroundColor: Colors.white,
    bottomBarColor: const Color(0xFF8400C0),
    cardSecondaryBackgroundColor: const Color(0xFFF1F0F0),
    cardShadowColor: const Color(0x17181818)
  );
}

class DarkTheme extends ThemeModel {
  DarkTheme()
      : super(
    primaryColor: const Color(0xFF1E1C28),
    accentColor: Colors.deepPurpleAccent[400]!,
    backgroundColor: const Color(0xFF0C0C0C),
    primaryTextColor: Colors.white,
    secondaryTextColor: Colors.white54,
    cardBackgroundColor: const Color(0xFF000000),
    bottomBarColor: const Color(0xFF000000),
    cardSecondaryBackgroundColor: const Color(0xFF171717),
    cardShadowColor: const Color(0xBAFAFAF)
  );
}

class ThemeProvider with ChangeNotifier {
  ThemeModel _themeModel = LightTheme();
  bool isDarkMode = false;

  ThemeModel get themeModel => _themeModel;

  void toggleTheme(bool isDark) {
    isDarkMode = isDark;
    _themeModel = isDarkMode ? DarkTheme() : LightTheme();
    notifyListeners();
  }
}
