import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  String currentTheme = 'system';

  ThemeMode get themeMode{
    if(currentTheme == 'light'){
      return ThemeMode.light;
    }else if(currentTheme == 'dark'){
      return ThemeMode.dark;
    }else{
      return ThemeMode.system;
    }
  }

  changeTheme(String theme) async {
    final pref = await SharedPreferences.getInstance();

    pref.setString('theme', theme);
    currentTheme = theme;
    notifyListeners();
  }

  getTheme() async{
    final pref = await SharedPreferences.getInstance();

    currentTheme = pref.getString('theme') ?? 'system';
    notifyListeners();
  }

  final darkTheme = ThemeData(
    // primarySwatch: Colors.amber,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: Color(0xFF000000),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.white,
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.amber,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black,
  );

}