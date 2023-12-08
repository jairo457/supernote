import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:super_note/Firebase/email_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final EmailAuth emailAuth = EmailAuth();
  String? cor;
  String? pas;
  TextEditingController TxtEmail = TextEditingController();
  TextEditingController TxtPass = TextEditingController();
  TextEditingController TxtComfirm = TextEditingController();
  final valid1 = false.obs;
  final valid2 = false.obs;
  final valid3 = false.obs;
  final valid4 = false.obs;
  final valid5 = false.obs; //iguales
  final valid6 = false.obs; //vali de confirm
  final valid7 = false.obs;
  final valid8 = false.obs; //Reenviar
  @override
  Widget build(BuildContext context) {
    /*final btnEntrar = TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
                Color.fromARGB(255, 245, 145, 145))),
        child: Text(
          valid8.value ? 'Reenviar' : 'Adelante!',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () async {
          if (TxtEmail.text.isEmpty ||
              TxtPass.text.isEmpty ||
              TxtComfirm.text.isEmpty) {
            TxtEmail.text.isEmpty ? valid1.value = true : valid1.value = false;
            TxtPass.text.isEmpty ? valid3.value = true : valid3.value = false;
            TxtComfirm.text.isEmpty
                ? valid6.value = true
                : valid6.value = false;
          } else {
            valid1.value = false;
            if (TxtEmail.text.isEmail) {
              valid2.value = false;
              if (TxtPass.text.length > 5) {
                valid4.value = false;
                if (TxtComfirm.text.length > 5) {
                  valid7.value = false;
                  if (TxtPass.text == TxtComfirm.text) {
                    valid5.value = false;
                    var email = TxtEmail.text;
                    var pwd = TxtPass.text;
                    cor = email;
                    pas = pwd;
                    emailAuth
                        .createUser(emailUser: email, pwdUser: pwd)
                        .then((value) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor:
                                  Color.fromARGB(255, 174, 195, 241),
                              content: IntrinsicHeight(
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        'Por favor confirma tu cuenta con el correo que fue enviado',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    });
                  } else {
                    valid5.value = true;
                  }
                } else {
                  valid7.value = true;
                }
              } else {
                valid4.value = true;
              }
            } else {
              valid2.value = true;
            }
          }
        });*/

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
                    'Registrate para tener todos los beneficios',
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
                          if (TxtPass.text.length >= 6) {
                            valid4.value = false;
                          }
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            label: Text(
                              'Contraseña',
                              style: TextStyle(color: Colors.amber),
                            ),
                            errorText: valid3.value
                                ? 'No puede estar vacio'
                                : valid4.value
                                    ? 'Debe tener mas de 5 digitos'
                                    : valid5.value
                                        ? 'Las contraseñas deben coincidir'
                                        : null,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber))),
                      ),
                      TextField(
                        controller: TxtComfirm,
                        onChanged: (teto) {
                          if (TxtComfirm.text.isNotEmpty) {
                            valid6.value = false;
                          }
                          if (TxtComfirm.text.length >= 6) {
                            valid4.value = false;
                          }
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            label: Text(
                              'Repetir Contraseña',
                              style: TextStyle(color: Colors.amber),
                            ),
                            errorText: valid6.value
                                ? 'No puede estar vacio'
                                : valid7.value
                                    ? 'Debe tener mas de 5 digitos'
                                    : valid5.value
                                        ? 'Las contraseñas deben coincidir'
                                        : null,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Color.fromARGB(255, 245, 145, 145))),
                          child: Text(
                            'Adelante!',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () async {
                            if (TxtEmail.text.isEmpty ||
                                TxtPass.text.isEmpty ||
                                TxtComfirm.text.isEmpty) {
                              TxtEmail.text.isEmpty
                                  ? valid1.value = true
                                  : valid1.value = false;
                              TxtPass.text.isEmpty
                                  ? valid3.value = true
                                  : valid3.value = false;
                              TxtComfirm.text.isEmpty
                                  ? valid6.value = true
                                  : valid6.value = false;
                            } else {
                              valid1.value = false;
                              if (TxtEmail.text.isEmail) {
                                valid2.value = false;
                                if (TxtPass.text.length > 5) {
                                  valid4.value = false;
                                  if (TxtComfirm.text.length > 5) {
                                    valid7.value = false;
                                    if (TxtPass.text == TxtComfirm.text) {
                                      valid5.value = false;
                                      var email = TxtEmail.text;
                                      var pwd = TxtPass.text;
                                      cor = email;
                                      pas = pwd;
                                      valid8.value = true;
                                      emailAuth
                                          .createUser(
                                              emailUser: email, pwdUser: pwd)
                                          .then((value) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor: Color.fromARGB(
                                                    255, 174, 195, 241),
                                                content: IntrinsicHeight(
                                                  child: Column(
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          'Por favor confirma tu cuenta con el correo que fue enviado',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      });
                                    } else {
                                      valid5.value = true;
                                    }
                                  } else {
                                    valid7.value = true;
                                  }
                                } else {
                                  valid4.value = true;
                                }
                              } else {
                                valid2.value = true;
                              }
                            }
                          }),
                      valid8.value
                          ? TextButton(
                              onPressed: () {
                                emailAuth.sendEmailVerification();
                              },
                              child: Text(
                                'Reenviar',
                                style: TextStyle(color: Colors.black),
                              ))
                          : Container()
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
