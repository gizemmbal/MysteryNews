import 'package:flutter/material.dart';
import 'package:news_app_api/helper/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SizedBox(
      width: 600,
      height: 350,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Switch.adaptive(
          activeColor: Colors.black,
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toggleTheme(value);
          },
        ),
      ),
    );
  }
}
