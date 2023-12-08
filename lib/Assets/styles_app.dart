import 'package:flutter/material.dart';

class StylesApp {
  final lightheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 171, 216, 235),
        onPrimary: Colors.orange,
        secondary: Colors.yellow,
        onSecondary: Colors.amber,
        error: const Color.fromARGB(255, 114, 54, 244),
        onError: Colors.grey,
        background: Colors.amber,
        onBackground: const Color.fromARGB(255, 96, 126, 151),
        surface: Color.fromARGB(255, 159, 197, 255), //scafold
        onSurface: Color.fromARGB(255, 203, 147, 57)),
    primaryColor: Color.fromARGB(255, 246, 175, 175),
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(color: Color.fromARGB(255, 211, 198, 255)),
    drawerTheme: DrawerThemeData(
        backgroundColor: Color.fromARGB(255, 211, 198, 255)), //drawer
    buttonTheme: ButtonThemeData(buttonColor: Colors.orange),
  );

  final darktheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color.fromARGB(255, 97, 69, 116),
        onPrimary: Colors.orange,
        secondary: Colors.yellow,
        onSecondary: Colors.amber,
        error: const Color.fromARGB(255, 114, 54, 244),
        onError: Colors.grey,
        background: Colors.amber,
        onBackground: Color.fromARGB(255, 109, 117, 48),
        surface: Color.fromARGB(255, 97, 69, 116),
        onSurface: Color.fromARGB(255, 97, 69, 116)), //Otuline color
    primaryColor: Color.fromARGB(255, 71, 67, 67),
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(color: Color.fromARGB(255, 185, 96, 90)),
    drawerTheme:
        DrawerThemeData(backgroundColor: Color.fromARGB(255, 185, 96, 90)),
    buttonTheme: ButtonThemeData(buttonColor: Colors.orange),
  );
}
