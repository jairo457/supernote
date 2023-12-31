import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:super_note/Firebase/email_auth.dart';

class LogEmailScreen extends StatefulWidget {
  const LogEmailScreen({super.key});

  @override
  State<LogEmailScreen> createState() => _LogEmailScreenState();
}

class _LogEmailScreenState extends State<LogEmailScreen> {
  final EmailAuth emailAuth = EmailAuth();
  String? cor;
  String? pas;
  TextEditingController TxtEmail = TextEditingController();
  TextEditingController TxtPass = TextEditingController();
  final valid1 = false.obs;
  final valid2 = false.obs;
  final valid3 = false.obs;
  @override
  Widget build(BuildContext context) {
    final btnEntrar = TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
                Color.fromARGB(255, 245, 145, 145))),
        child: Text(
          'Ingresar',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () async {
          if (TxtEmail.text.isEmpty || TxtPass.text.isEmpty) {
            TxtEmail.text.isEmpty ? valid1.value = true : valid1.value = false;
            TxtPass.text.isEmpty ? valid3.value = true : valid3.value = false;
          } else {
            valid1.value = false;
            if (TxtEmail.text.isEmail) {
              valid2.value = false;
              var email = TxtEmail.text;
              var pwd = TxtPass.text;
              cor = email;
              pas = pwd;
              bool res = await emailAuth.validateUser(
                  emailUser: TxtEmail.text, pwdUser: TxtPass.text);
              if (res) {
                Navigator.pushNamed(context, '/home');
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Color.fromARGB(255, 174, 195, 241),
                        content: IntrinsicHeight(
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  'Correo o contraseña incorrectos',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            } else {
              valid2.value = true;
            }
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
                    'Iniciar sesion',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Container(
                  //decoration:BoxDecoration(color: Color.fromARGB(255, 228, 224, 224)),
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      TextField(
                        style: TextStyle(color: Colors.black),
                        controller: TxtEmail,
                        onChanged: (teto) {
                          if (TxtEmail.text.isNotEmpty) {
                            valid1.value = false;
                          }
                          if (TxtEmail.text.isEmail) {
                            valid2.value = false;
                          }
                        },
                        decoration: InputDecoration(
                            label: Text(
                              'Correo',
                              style: TextStyle(color: Colors.amber),
                            ),
                            errorText: valid1.value
                                ? 'No puede estar vacio'
                                : valid2.value
                                    ? 'Ingrese un correo por favor'
                                    : null,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber))),
                      ),
                      TextField(
                        controller: TxtPass,
                        onChanged: (teto) {
                          if (TxtPass.text.isNotEmpty) {
                            valid3.value = false;
                          }
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            label: Text(
                              'Contraseña',
                              style: TextStyle(color: Colors.amber),
                            ),
                            errorText:
                                valid3.value ? 'No puede estar vacio' : null,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/reco');
                          },
                          child: Text(
                            '¿Olvidaste tu contraseña? ',
                            style: TextStyle(color: Colors.black),
                          )),
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
