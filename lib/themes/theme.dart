import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 141, 121, 179),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 84, 64, 127),
    onSecondary: Colors.white,
    error: Color.fromARGB(255, 6, 0, 3),
    onError: Colors.white,
    surface: Color.fromARGB(255, 229, 221, 239),
    onSurface: Colors.black87);

const darkColorScheme = ColorScheme.dark(
    primary: Color.fromARGB(255, 141, 121, 179),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 84, 64, 127),
    onSecondary: Colors.white,
    error: Color.fromARGB(255, 11, 0, 6),
    onError: Colors.white,
    surface: Color.fromARGB(255, 229, 221, 239),
    onSurface: Colors.black87);

ThemeData lightMode = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: lightColorScheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor:
          WidgetStateProperty.all<Color>(lightColorScheme.primary),
      foregroundColor:
          WidgetStateProperty.all<Color>(lightColorScheme.onPrimary),
   elevation: WidgetStateProperty.all<double>(5.0), // shadow
      padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Adjust as needed
        ),
      ),
    ),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
); 