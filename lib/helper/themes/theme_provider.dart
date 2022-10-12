import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color.fromARGB(255, 139, 139, 139),
    primaryColor: Color.fromARGB(255, 139, 139, 139),
    backgroundColor: Color.fromARGB(255, 139, 139, 139),
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.black, opacity: 0.8),
    buttonTheme:
        ButtonThemeData(buttonColor: Color.fromARGB(255, 139, 139, 139)),
    appBarTheme: AppBarTheme(backgroundColor: Color.fromARGB(255, 81, 81, 81)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 81, 81, 81))),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        bodyText2:
            TextStyle(color: Color.fromARGB(255, 201, 201, 201), fontSize: 14)),
  );

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.white,
      colorScheme: ColorScheme.light(),
      iconTheme: IconThemeData(color: Color.fromARGB(255, 243, 93, 33)),
      appBarTheme: AppBarTheme(color: Color.fromARGB(255, 255, 190, 212)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 255, 190, 212))),
      textTheme: TextTheme(
          bodyText1: TextStyle(
              color: Colors.orange, fontSize: 20, fontWeight: FontWeight.w500),
          bodyText2: TextStyle(
              color: Color.fromARGB(255, 255, 127, 77), fontSize: 14)));
}
/*
  Color orange = Color.fromARGB(255, 243, 93, 33);
  Color pink = Color.fromARGB(255, 255, 190, 212);
  Color dark_grey = Color.fromARGB(255, 81, 81, 81);
  Color light_grey = Color.fromARGB(255, 139, 139, 139);

fontSize: 20,
fontWeight: FontWeight.w500

color: Color.fromARGB(255, 255, 127, 77), fontSize: 14
*/