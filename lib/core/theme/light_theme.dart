import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(),
  scaffoldBackgroundColor: Color(0xfff5f5f5),
  appBarTheme: AppBarThemeData(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF141414)),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: LightColors.primaryColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColors.primaryColor,
      foregroundColor: Color(0xfff5f5f5),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: LightColors.backgroundColor,
    selectedItemColor: LightColors.primaryColor,
    unselectedItemColor: LightColors.unselectedItemColor,
    showUnselectedLabels: true,
  ),

  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.all(16),

    hintStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: LightColors.unselectedItemColor,
    ),
    border: InputBorder.none,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
);
