import 'package:flutter/material.dart';

final ThemeData sportsPokerTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.red[900]!,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.red[900]!,
    onPrimary: Colors.white,
    secondary: Colors.amber[600]!,
    onSecondary: Colors.black,
    surface: const Color(0xFF1A1A1A),
    onSurface: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
        color: Colors.grey[300], fontSize: 16, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(
        color: Colors.grey[400], fontSize: 14, fontWeight: FontWeight.bold),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.red[900],
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
);
