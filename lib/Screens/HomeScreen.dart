import 'dart:async';

import 'package:day_night_switch/day_night_switch.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:super_note/Assets/ThemeServices.dart';
import 'package:super_note/Assets/global_values.dart';
import 'package:super_note/Assets/styles_app.dart';
import 'package:super_note/Models/NoteModel.dart';
import 'package:super_note/Widgets/NoteWidgetView.dart';
import 'package:super_note/Widgets/NoteWidgetViewCube.dart';
import 'package:super_note/database/Masterdb.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MasterDB? masterDB;
  User? user;

  @override
  void initState() {
    super.initState();
    masterDB = MasterDB();
    GetU();
  }

  Future<void> _singOut() async {
    FirebaseAuth.instance.signOut();
  }

  GetU() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final Settings = TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/set');
        },
        child: Row(children: [
          Icon(Icons.settings),
          SizedBox(
            width: 10,
          ),
          Text(
            'Ajustes',
            style: TextStyle(fontSize: 20),
          ),
        ]));

    Widget createDrawer(context) {
      return Drawer(
        child: Stack(clipBehavior: Clip.antiAlias, children: [
          /*  Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/set');
                  },
                  child: Text('hola'))),*/
          /*Positioned(
            bottom: 0,
            left: 170,
            width: MediaQuery.of(context).size.width,
            child: Settings,
          ),*/
          ListView(
            children: [
              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                  ),
                  accountName: Text("Correo"),
                  accountEmail: Text(user!.email!.toString())),
              ListTile(
                leading: Icon(Icons.account_circle_sharp),
                trailing: Icon(Icons.chevron_right),
                title: Text(
                  'Perfil',
                  style: TextStyle(
                      fontFamily: 'Pixel',
                      fontSize: MediaQuery.of(context).size.width / 18),
                ),
                onTap: () => Navigator.pushNamed(context, '/perf'),
              ),
              ListTile(
                leading: Icon(Icons.color_lens),
                trailing: Icon(Icons.chevron_right),
                title: Text('Tema',
                    style: TextStyle(
                        fontFamily: 'Pixel',
                        fontSize: MediaQuery.of(context).size.width / 18)),
                onTap: () => Navigator.pushNamed(context, '/them'),
              ),
              ListTile(
                leading: Icon(Icons.door_front_door_outlined),
                trailing: Icon(Icons.logout),
                title: Text('Cerrar Sesion',
                    style: TextStyle(
                        fontFamily: 'Pixel',
                        fontSize: MediaQuery.of(context).size.width / 20)),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  GoogleSignIn().signOut();
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ]),
      );
    }

    final Alarmas = TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
                Color.fromARGB(255, 238, 78, 78)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Alarmas",
              style: TextStyle(
                  fontSize: 13.0, fontFamily: "Raleway", color: Colors.black),
            ),
            Icon(Icons.punch_clock)
          ],
        ),
        onPressed: () {});

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
      ),
      drawer: createDrawer(context),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          DigitalClock(
            digitAnimationStyle: Curves.bounceOut,
            is24HourTimeFormat: false,
            hourMinuteDigitTextStyle:
                TextStyle(fontSize: MediaQuery.of(context).size.width / 9),
            secondDigitTextStyle:
                TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
            amPmDigitTextStyle:
                TextStyle(fontSize: MediaQuery.of(context).size.width / 25),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.view_module,
                  size: MediaQuery.of(context).size.width / 10),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.view_list,
                  size: MediaQuery.of(context).size.width / 10,
                ))
          ]),
          Obx(
            () => ExpandablePageView(
              scrollDirection: Axis.horizontal,
              controller: pageController,
              children: <Widget>[
                ListView(shrinkWrap: true, children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.5, color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/edit');
                            },
                            icon: Icon(Icons.note_add,
                                size: MediaQuery.of(context).size.width / 11)),
                        Text(GlobalValues.flagNote.value ? '' : '')
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: masterDB!.GETALL_Note(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<NoteModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return NoteWidgetView(
                                  noteModel: snapshot.data![index],
                                  masterDB: masterDB,
                                );
                              });
                        } else {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error!'),
                            );
                          } else {
                            return const Center(
                              child: Text('Sin notas'),
                            );
                          }
                        }
                      })
                ]),
                Center(
                  child: Text('Second Page'),
                ),
                Center(
                  child: Text('Third Page'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
