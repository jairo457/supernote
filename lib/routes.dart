import 'package:flutter/material.dart';
import 'package:super_note/Screens/HomeScreen.dart';
import 'package:super_note/Screens/LoginScreen.dart';
import 'package:super_note/Screens/NoteEdit.dart';
import 'package:super_note/Screens/SettingsScreen.dart';
import 'package:super_note/Screens/SingScreen.dart';

Map<String, WidgetBuilder> GetRoutes() {
  return {
    '/home': (BuildContext context) => HomeScreen(),
    '/login': (BuildContext context) => LoginScreen(),
    '/sing': (BuildContext context) => SingScreen(),
    '/newto': (BuildContext context) => NoteEdit(),
    '/edit': (BuildContext context) => NoteEdit(),
    '/set': (BuildContext context) => SettingsScreen(),
    /* '/detail': (BuildContext context) => DetailMovieScreen(),
    '/fav': (BuildContext context) => FavScreen(),
    '/basic': (BuildContext context) => LoginScreen(),*/
  };
}
