import 'package:flutter/material.dart';
import 'package:news_app_api/helper/themes/theme_provider.dart';
//import 'package:news_app_api/helper/weather/currentWeather.dart';
import 'package:news_app_api/views/HomePage.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String title = 'Light & Dark Theme';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            title: title,
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: HomePage(),
            debugShowCheckedModeBanner: false,
          );
        },
      );
}
