import 'package:flutter/material.dart';
import 'package:super_note/Screens/HomeScreen.dart';
import 'package:super_note/Screens/LoginScreen.dart';

Map<String, WidgetBuilder> GetRoutes() {
  return {
    '/home': (BuildContext context) => HomeScreen(),
    '/login': (BuildContext context) => LoginScreen(),
    /*'/popular': (BuildContext context) => PopularScreen(),
    '/detail': (BuildContext context) => DetailMovieScreen(),
    '/fav': (BuildContext context) => FavScreen(),
    '/basic': (BuildContext context) => LoginScreen(),*/
  };
}
