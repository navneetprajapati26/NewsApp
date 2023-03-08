import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {

  var _themeMode = ThemeMode.light;

  get themeMode => _themeMode;
  void changeTheme() {
    if(_themeMode == ThemeMode.light){
      _themeMode = ThemeMode.dark;
    }else{
      _themeMode =ThemeMode.light;
    }
    notifyListeners();
  }
}
