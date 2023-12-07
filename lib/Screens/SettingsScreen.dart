import 'dart:async';

import 'package:flutter/material.dart';
import 'package:super_note/Firebase/email_auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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

    final txtPass = TextField(
        controller: txtConPass,
        style: TextStyle(color: Colors.black),
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: 'Contraseña'));

    final imgLogo = Container(
      width: 300,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Mario_Series_Logo.svg/1280px-Mario_Series_Logo.svg.png'))),
    );

    final btnEntrar = TextButton(
        child: Text('Entrar'),
        onPressed: () async {
          bool res = await emailAuth.validateUser(
              emailUser: txtConUser.text, pwdUser: txtConPass.text);
          if (res) {
            Navigator.pushNamed(context, '/home');
          }
        });

    final GoogleButton = TextButton(
      style: ButtonStyle(
          foregroundColor: const MaterialStatePropertyAll<Color>(
              Color.fromARGB(255, 248, 243, 243)),
          backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Ingresar con google",
            style: TextStyle(
                fontSize: 13.0, fontFamily: "Raleway", color: Colors.black),
          ),
          Image.asset(
            'assets/google_icon.png',
            width: 20,
            height: 20,
          ),
        ],
      ),
      onPressed: () async {
        bool res = await emailAuth.signInWithGoogle();
        if (res) {
          Navigator.pushNamed(context, '/home');
        }
      },
    );
    final GitButton = TextButton(
        style: ButtonStyle(
            foregroundColor:
                const MaterialStatePropertyAll<Color>(Colors.white),
            backgroundColor: const MaterialStatePropertyAll<Color>(
                Color.fromARGB(255, 232, 230, 230)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Ingresar con Github",
              style: TextStyle(
                  fontSize: 13.0, fontFamily: "Raleway", color: Colors.black),
            ),
            Image.asset(
              'assets/Git_icon.png',
              width: 20,
              height: 20,
            ),
          ],
        ),
        onPressed: () async {
          bool res = await emailAuth.signInWithGitHub();
          if (res) {
            Navigator.pushNamed(context, '/home');
          }
        });

    final FaceButton = TextButton(
      style: ButtonStyle(
          foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
          backgroundColor: const MaterialStatePropertyAll<Color>(
              Color.fromARGB(255, 75, 71, 186)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Ingresar con facebook',
            style: TextStyle(
                fontSize: 13.0, fontFamily: "Raleway", color: Colors.white),
          ),
          Image.asset(
            'assets/Face_icon.png',
            width: 20,
            height: 20,
          ),
        ],
      ),
      onPressed: () {},
    );

    final CommunButton = TextButton(
      style: ButtonStyle(
          foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
          backgroundColor: const MaterialStatePropertyAll<Color>(
              Color.fromARGB(255, 171, 169, 169)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Ingresar con correo',
            style: TextStyle(
                fontSize: 13.0, fontFamily: "Raleway", color: Colors.white),
          ),
          Image.asset(
            'assets/email.png',
            width: 20,
            height: 20,
          ),
        ],
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/loge');
      },
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
            leading: Icon(Icons.color_lens),
            trailing: Icon(Icons.chevron_right),
            title: Text('Tema'),
            onTap: () => Navigator.pushNamed(context, '/popular'),
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            trailing: Icon(Icons.chevron_right),
            title: Text('Tema'),
            onTap: () => Navigator.pushNamed(context, '/popular'),
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            trailing: Icon(Icons.chevron_right),
            title: Text('Tema'),
            onTap: () => Navigator.pushNamed(context, '/popular'),
          ),
          ListTile(
            leading: Icon(Icons.font_download_outlined),
            trailing: Icon(Icons.chevron_right),
            title: Text('Fuentes'),
            onTap: () => Navigator.pushNamed(context, '/popular'),
          ),
        ],
      ),
    );
  }
}
