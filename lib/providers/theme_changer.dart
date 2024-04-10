import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeChanger with ChangeNotifier {
  static bool isDark = true;

  static late final Box box;

  ThemeChanger() {
    if (box.containsKey('themestore')) {
      isDark = box.get('themestore');
    } else {
      box.put('themestore', isDark);
    }
  }

  ThemeMode get currentTheme {
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    isDark = !isDark;
    box.put('themestore', isDark);
    notifyListeners();
  }
}
