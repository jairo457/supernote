import 'package:flutter/material.dart';
import 'package:super_note/Screens/AccountScreen.dart';
import 'package:super_note/Screens/HomeScreen.dart';
import 'package:super_note/Screens/LogEmail.dart';
import 'package:super_note/Screens/LoginScreen.dart';
import 'package:super_note/Screens/NoteEdit.dart';
import 'package:super_note/Screens/RecoveryScreen.dart';
import 'package:super_note/Screens/RegisterScreen.dart';
import 'package:super_note/Screens/SettingsScreen.dart';

Map<String, WidgetBuilder> GetRoutes() {
  return {
    '/home': (BuildContext context) => HomeScreen(),
    '/login': (BuildContext context) => LoginScreen(),
    '/newto': (BuildContext context) => NoteEdit(),
    '/edit': (BuildContext context) => NoteEdit(),
    '/them': (BuildContext context) => ThemeScreen(),
    '/reg': (BuildContext context) => RegisterScreen(),
    '/logE': (BuildContext context) => LogEmailScreen(),
    '/reco': (BuildContext context) => RecoveryScreen(),
    '/perf': (BuildContext context) => AccountScreen(),
  };
}
