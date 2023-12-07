import 'dart:async';

import 'package:flutter/material.dart';
import 'package:super_note/Firebase/email_auth.dart';

class SingScreen extends StatefulWidget {
  const SingScreen({super.key});

  @override
  State<SingScreen> createState() => _SingScreenState();
}

class _SingScreenState extends State<SingScreen> {
  final EmailAuth emailAuth = EmailAuth();
  TextEditingController TxtEmail = TextEditingController();
  TextEditingController TxtPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final txtUser = TextField(
      style: TextStyle(color: Colors.black),
      controller: TxtEmail,
      decoration: const InputDecoration(
          label: Text(
            'Correo',
            style: TextStyle(color: Colors.amber),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amber))),
    );

    final txtPass = TextField(
      controller: TxtPass,
      style: TextStyle(color: Colors.black),
      decoration: const InputDecoration(
          label: Text(
            'Contraseña',
            style: TextStyle(color: Colors.amber),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amber))),
    );

    final btnEntrar = TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
                Color.fromARGB(255, 245, 145, 145))),
        child: Text('Adelante!'),
        onPressed: () async {
          String ti = TxtPass.text;
          if (ti.length > 5) {
            var email = TxtEmail.text;
            var pwd = TxtPass.text;
            emailAuth.createUser(emailUser: email, pwdUser: pwd).then((value) {
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
                                'Por favor confirma tu cuenta con el correo que fue enviado',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
              Navigator.pushNamed(context, '/login');
            });
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
                              'La contraseña debe tener mas de 6 caracteres',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
        });

    return Scaffold(
      body: Container(
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
                  'Registrate para obtener todos los beneficios',
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
    );
  }
}
