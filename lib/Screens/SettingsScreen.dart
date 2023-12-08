import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:super_note/Assets/ThemeServices.dart';
import 'package:super_note/Firebase/email_auth.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  final EmailAuth emailAuth = EmailAuth();
  TextEditingController txtConUser = TextEditingController();
  TextEditingController txtConPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final txtUser = TextField(
      style: TextStyle(color: Colors.black),
      controller: txtConUser,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Usuario'),
    );
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Ajustes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: Icon(Icons.mode_night),
            title: Text('Oscuro'),
            onTap: () {
              ThemeServices().changeThemeMode();
            },
          ),
          /*ListTile(
            leading: Icon(Icons.light_mode),
            title: Text('Claro'),
            onTap: () {
              Get.changeThemeMode(ThemeMode.light);
              Get.changeTheme(ThemeData.light());
            },
          ),*/
        ],
      ),
    );
  }
}
