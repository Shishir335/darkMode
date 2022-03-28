import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode? themeMode;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  toggleTheme(bool value) {
    themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  setTheme(bool value) {
    themeMode = value ? ThemeMode.dark : ThemeMode.light;
    // notifyListeners();
  }

  // getMood() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (prefs.getBool('dark')!) {
  //     return ThemeMode.dark;
  //   } else {
  //     return ThemeMode.light;
  //   }
  // }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
  );
}
