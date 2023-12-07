import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:super_note/Firebase/email_auth.dart';

class LogEmail extends StatefulWidget {
  const LogEmail({super.key});

  @override
  State<LogEmail> createState() => _LogEmailState();
}

class _LogEmailState extends State<LogEmail> {
  final EmailAuth emailAuth = EmailAuth();
  TextEditingController TxtEmail = TextEditingController();
  TextEditingController TxtPass = TextEditingController();
  final valid1 = false.obs;
  final valid2 = false.obs;

  @override
  Widget build(BuildContext context) {
    final txtUser = TextField(
      style: TextStyle(color: Colors.black),
      controller: TxtEmail,
      decoration: InputDecoration(
          label: Text(
            'Correo',
            style: TextStyle(color: Colors.amber),
          ),
          errorText: valid1.value ? 'No puede estar vacio' : null,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amber))),
    );

    final txtPass = TextField(
      controller: TxtPass,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          label: Text(
            'Contraseña',
            style: TextStyle(color: Colors.amber),
          ),
          errorText: valid2.value ? 'No puede estar vacio' : null,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amber))),
    );

    final btnEntrar = TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
                Color.fromARGB(255, 245, 145, 145))),
        child: Text('Adelante!'),
        onPressed: () async {
          if (TxtEmail.text == '') {
            valid1.value = true;
          } else {
            bool res = await emailAuth.validateUser(
                emailUser: TxtEmail.text, pwdUser: TxtPass.text);
            if (res) {
              Navigator.pushNamed(context, '/home');
            }
          }
          if (TxtPass.text.isEmpty) {
            valid2.value = true;
          }
        });

    return Scaffold(
      body: Obx(
        () => Container(
            height: MediaQuery.of(context).size.height,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 255, 245, 233)),
            child: ListView(
              shrinkWrap: true,
              children: [
                Icon(
                  color: Color.fromARGB(255, 166, 11, 138),
                  Icons.edit_note,
                  size: 80,
                ),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'Por favor ingresa tu correo y contraseña',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Container(
                  //decoration:BoxDecoration(color: Color.fromARGB(255, 228, 224, 224)),
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      txtUser,
                      txtPass,
                      SizedBox(
                        height: 20,
                      ),
                      btnEntrar
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
