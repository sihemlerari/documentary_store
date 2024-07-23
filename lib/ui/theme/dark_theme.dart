import 'package:flutter/material.dart';

const primaryColor = Color(0xff232539);
const secondaryColor = Color(0xfffca611);
const scaffoldBackgroundColor = Color(0xff211f2d);
const defaultTextColor = Colors.white;

ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
    onSecondary: Colors.white,
    tertiary: const Color(0xff3b36bb),
    surface: const Color(0xff3c4b70),
    error: const Color(0xffd3323c),
  ),
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
    foregroundColor: primaryColor,
  ),
  disabledColor: Colors.grey[400],
  appBarTheme: appBarTheme(),
  textTheme: textTheme(),
  elevatedButtonTheme: elevatedButtonTheme(),
);

AppBarTheme appBarTheme() => const AppBarTheme(
      color: primaryColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
    );

TextTheme textTheme() => const TextTheme(
      headlineMedium: TextStyle(
        color: defaultTextColor,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(color: defaultTextColor),
      titleMedium: TextStyle(color: defaultTextColor),
      bodyLarge: TextStyle(color: defaultTextColor),
      bodyMedium: TextStyle(color: defaultTextColor),
      bodySmall: TextStyle(color: defaultTextColor),
    );

ElevatedButtonThemeData elevatedButtonTheme() => ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
