import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 141, 121, 179),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 84, 64, 127),
    onSecondary: Colors.white,
    error: Color.fromARGB(255, 6, 0, 3),
    onError: Colors.white,
    background: Color.fromARGB(255, 209, 196, 234),
    onBackground: Colors.black87,
    surface: Color.fromARGB(255, 229, 221, 239),
    onSurface: Colors.black87);

const darkColorScheme = ColorScheme.dark(
    primary: Color.fromARGB(255, 141, 121, 179),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 84, 64, 127),
    onSecondary: Colors.white,
    error: Color.fromARGB(255, 11, 0, 6),
    onError: Colors.white,
    background: Color.fromARGB(255, 209, 196, 234),
    onBackground: Colors.black87,
    surface: Color.fromARGB(255, 229, 221, 239),
    onSurface: Colors.black87);

ThemeData lightMode = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: lightColorScheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(lightColorScheme.primary),
      foregroundColor:
          MaterialStateProperty.all<Color>(lightColorScheme.onPrimary),
   elevation: MaterialStateProperty.all<double>(5.0), // shadow
      padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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