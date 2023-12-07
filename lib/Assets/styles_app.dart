import 'package:flutter/material.dart';

class StylesApp {
  final lightheme = ThemeData.light().copyWith(
      /* textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: TextStyle(color: Colors.cyan),
        ),
      ),*/
      primaryColor: Color.fromARGB(255, 246, 175, 175));

  final darktheme = ThemeData.dark().copyWith(
    /*textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: TextStyle(color: Colors.black),
      ),
    ),*/
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color.fromARGB(255, 240, 228, 228),
        onPrimary: Colors.orange,
        secondary: Colors.yellow,
        onSecondary: Colors.amber,
        error: const Color.fromARGB(255, 114, 54, 244),
        onError: Colors.grey,
        background: Colors.amber,
        onBackground: Colors.blue,
        surface: Color.fromARGB(255, 255, 255, 255),
        onSurface: Color.fromARGB(255, 255, 255, 255)), //Otuline color
    primaryColor: Color.fromARGB(255, 71, 67, 67),
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(color: const Color.fromARGB(255, 185, 96, 90)),
    drawerTheme:
        DrawerThemeData(backgroundColor: Color.fromARGB(255, 185, 96, 90)),
    buttonTheme: ButtonThemeData(buttonColor: Colors.orange),
  );
}
