import 'package:flutter/material.dart';

class AppTheme {
  static const primaryLight = Colors.purpleAccent;
  static const secondaryLight = Colors.lightBlue;
  static const backgroundLight = Colors.white;
  static const textLight = Colors.black;

  static const primaryDark = Colors.purpleAccent;
  static const secondaryDark = Colors.lightBlue;
  static const backgroundDark = Color(0xFF121212);
  static const textDark = Colors.white;

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryLight,
    scaffoldBackgroundColor: backgroundLight,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textLight),
      bodyMedium: TextStyle(color: textLight),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 20,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      alignLabelWithHint: true,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryDark,
    scaffoldBackgroundColor: backgroundDark,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textDark),
      bodyMedium: TextStyle(color: textDark),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 20,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      alignLabelWithHint: true,
    ),
  );
} 