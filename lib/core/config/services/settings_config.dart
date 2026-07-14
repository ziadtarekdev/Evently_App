import 'package:flutter/material.dart';

class SettingsConfig  extends ChangeNotifier{
  ThemeMode currentTheme=ThemeMode.light;
  void  changeTheme(ThemeMode themeMode){
  if(themeMode==currentTheme){
    return;
  }
  currentTheme=themeMode;
  notifyListeners();
  }
}