import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  bool _isDark = false;

  bool getThemeValue() => _isDark;

  setThemeValue(bool value){
    _isDark = value;
    notifyListeners();
  }

}