import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statisticalcorona/utils/theme_data.dart';

class ThemeProvider with ChangeNotifier{
  final String key = 'theme';
  bool _darkTheme = false;

  bool get isDarkTheme => _darkTheme;
  SharedPreferences sharedPreferences;

  ThemeProvider(){
      _loadData();
  }
  Future initialPref()async {
    if (sharedPreferences == null) {
        sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  ThemeData get getTheme {
    return _darkTheme ? darkTheme : lightTheme;
  }

  toggleTheme(){
    _darkTheme =!_darkTheme;
    sharedPreferences.setBool(key, _darkTheme);
    notifyListeners();
  }

  _loadData() async {
    await initialPref();
    _darkTheme = sharedPreferences.getBool(key) ?? false;
    notifyListeners();
  }


}
