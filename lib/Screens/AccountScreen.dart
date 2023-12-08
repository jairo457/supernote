import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_note/Firebase/Databasefirebase.dart';
import 'package:super_note/Firebase/email_auth.dart';
import 'dart:io';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final EmailAuth emailAuth = EmailAuth();
  PlatformFile? pickedfile;
  DatabaseFirebase up = DatabaseFirebase();
  User? user;
  String? imageUrl;
  String? correo;
  String? id;
  String? imagen;
  String? descripcion;
  String? usuario;
  bool check1 = false;
  final valid1 = false.obs;
  TextEditingController TxtDescription = TextEditingController();
  TextEditingController TxtUser = TextEditingController();
  @override
  void initState() {
    super.initState();
    GetU();
  }

  GetU() async {
    user = FirebaseAuth.instance.currentUser;
  }

  Future selectfile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      pickedfile = result.files.first;
      valid1.value = true;
    }
  }

  Future<void> uploadFile() async {
    final path = 'files/${pickedfile!.name}';
    final file = File(pickedfile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }

  Future<void> getURLImage(filo) async {
    final storageRef = FirebaseStorage.instance.ref();
    imageUrl = await storageRef.child(filo).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    final btnSave = TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
                Color.fromARGB(255, 245, 145, 145))),
        child: Text(
          'Guardar',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () async {
          //print(imageUrl);
          //print(id);
          if (valid1.value) {
            uploadFile();
          }
          check1
              ? up.updFavorite({
                  'correo': user!.email!.toString(),
                  'description': TxtDescription.text,
                  'imagen': valid1.value ? 'files/${pickedfile!.name}' : imagen,
                  'user': TxtUser.text,
                }, id!).then((value) => Navigator.pushNamed(context, '/home'))
              : up.insFavorite({
                  'correo': user!.email!.toString(),
                  'description': TxtDescription.text,
                  'imagen': 'files/${pickedfile!.name}',
                  'user': TxtUser.text,
                }).then((value) => Navigator.pushNamed(context, '/home'));
        });

    final txtDescription = TextFormField(
        controller: TxtDescription,
        maxLines: null,
        decoration: InputDecoration(
            label: Text(
              'Descripcion',
              style: TextStyle(color: Colors.amber),
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.amber))));
    final txtUser = TextFormField(
        controller: TxtUser,
        decoration: InputDecoration(
            label: Text(
              'Nombre de usuario',
              style: TextStyle(color: Colors.amber),
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.amber))));

    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            'Cuenta',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: StreamBuilder(
            stream: up.getAllFavorites(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data!.docs!.length);
                //var dat = snapshot.data!.docs[0].get('correo');
                for (int i = 0; i < snapshot.data!.docs!.length; i++) {
                  String tepo = snapshot.data!.docs[i].get('correo');
                  //print('tepo: ' + tepo);
                  //print('email: ' + user!.email!.toString());
                  if (tepo == user!.email!.toString()) {
                    id = snapshot.data!.docs[0]!.id;
                    correo = tepo;
                    descripcion = snapshot.data!.docs[i].get('description');
                    usuario = snapshot.data!.docs[i].get('user');
                    imagen = snapshot.data!.docs[i].get('imagen');
                    check1 = true;
                    //print(imageUrl);
                    //print('hola');

                    break;
                  }
                }
                //print(correo);
                //print('hola');
                if (check1) {
                  TxtDescription.text = descripcion!;
                  TxtUser.text = usuario!;
                }
                return Obx(
                  () => ListView(
                    shrinkWrap: true,
                    children: [
                      valid1.value ? Container() : Container(),
                      check1
                          ? FutureBuilder(
                              future: getURLImage(imagen),
                              builder: (context, snapshot) {
                                if (!snapshot.hasError) {
                                  return GestureDetector(
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.height /
                                              10,
                                      backgroundImage: valid1.value
                                          ? Image.file(File(pickedfile!.path!))
                                              .image
                                          : check1
                                              ? Image.network(
                                                  imageUrl!,
                                                  //fit: BoxFit.scaleDown,
                                                ).image
                                              : NetworkImage(
                                                  'https://i.pravatar.cc/300'),
                                    ),
                                    onTap: () {
                                      selectfile();
                                    },
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              })
                          : GestureDetector(
                              child: CircleAvatar(
                                radius: MediaQuery.of(context).size.height / 10,
                                backgroundImage: valid1.value
                                    ? Image.file(File(pickedfile!.path!)).image
                                    : check1
                                        ? Image.network(
                                            imageUrl!,
                                            //fit: BoxFit.scaleDown,
                                          ).image
                                        : NetworkImage(
                                            'https://i.pravatar.cc/300'),
                              ),
                              onTap: () {
                                selectfile();
                              },
                            ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Center(
                          child: Text(
                        "Correo",
                        style: TextStyle(fontSize: 30),
                      )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                      ),
                      Center(
                          child: Text(user!.email!.toString(),
                              style: TextStyle(fontSize: 15))),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                      ),
                      txtDescription,
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                      ),
                      txtUser,
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                      ),
                      btnSave
                    ],
                  ),
                );
              } else {
                if (snapshot.hasError) {
                  return Center(child: Text('error'));
                } else {
                  return CircularProgressIndicator();
                }
              }
            }));
  }
}
