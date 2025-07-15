import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor = Colors.indigo;
  static const Color _secondaryColor = Colors.orange;

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _primaryColor,
    highlightColor:Colors.black ,
    scaffoldBackgroundColor: Colors.white,
    hintColor: Colors.grey.shade500,
    colorScheme: ColorScheme.light(
      primary: _primaryColor,
      secondary: _secondaryColor,
      surface: Colors.white,
      background: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: _primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey.shade600),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _primaryColor,
     highlightColor:Colors.white ,
    scaffoldBackgroundColor: Colors.black,
    hintColor: Colors.grey.shade400,
    colorScheme: ColorScheme.dark(
      primary: _primaryColor,
      secondary: _secondaryColor,
      surface: Colors.grey[900]!,
      background: Colors.black,
      error: Colors.red.shade400,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.black,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: _primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey.shade400),
    ),
  );
}
