import 'package:flutter/material.dart';

final ThemeData sportsPokerTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.red[900]!, // Deep red as the primary color
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.red[900]!, // Matches the dominant red tones
    onPrimary: Colors.white, // Text on primary buttons
    secondary: Colors.amber[600]!, // Golden yellow for accents
    onSecondary: Colors.black, // Text on secondary elements
    surface: const Color(
        0xFF1A1A1A), // Slightly lighter than black for card surfaces
    onSurface: Colors.white, // Text on surface
    error: Colors.redAccent, // Error colors
    onError: Colors.white, // Text for error messages
  ),
  scaffoldBackgroundColor: Colors.black, // Matches the dark background
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
    buttonColor: Colors.red[900], // Red for call-to-action buttons
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
