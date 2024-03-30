//theme_provider.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode;

  ThemeProvider({ThemeMode initialThemeMode = ThemeMode.system}) : themeMode = initialThemeMode;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  
  
  // Define colors for light theme
  Color get lightTextColor => WebColors.lightTextColor;
  Color get lightBackgroundColor => WebColors.lightBackgroundColor;

  // Define colors for dark theme
  Color get darkTextColor => WebColors.darkTextColor;
  Color get darkBackgroundColor => WebColors.darkBackgroundColor;


  // Dynamic color getters based on theme mode
  Color get textColor => !isDarkMode ? lightTextColor : darkTextColor;
  Color get backgroundColor => !isDarkMode ? lightBackgroundColor : darkBackgroundColor;
  Color get antiTextColor => isDarkMode ? lightTextColor : darkTextColor;
  Color get antiBackgroundColor => isDarkMode ? lightBackgroundColor : darkBackgroundColor;
  
}
