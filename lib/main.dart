import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_note/Assets/ThemeServices.dart';
import 'package:super_note/Assets/styles_app.dart';
import 'package:super_note/Screens/HomeScreen.dart';
import 'package:super_note/Screens/LoginScreen.dart';
import 'package:super_note/Screens/OnBoardingScreen.dart';
import 'package:super_note/Screens/SettingsScreen.dart';
import 'package:super_note/Utils/Noti_service.dart';
import 'package:super_note/Utils/firebase_api.dart';
import 'package:super_note/routes.dart';
import 'package:timezone/data/latest.dart' as tz;

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //para inicializar
  await FirebaseApi().initNotifications();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  await GetStorage.init();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MainApp(showHome: showHome));
}

class MainApp extends StatelessWidget {
  final bool showHome;
  MainApp({super.key, required this.showHome});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: GetRoutes(),
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      theme: StylesApp().lightheme,
      darkTheme: StylesApp().darktheme,
      themeMode: ThemeServices().getThemeMode(),
      home: showHome
          ? StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.emailVerified!) {
                    return HomeScreen();
                  } else {
                    return LoginScreen();
                  }
                } else {
                  return LoginScreen();
                }
              },
            )
          : OnBoardingScreen(),
    );
  }
}
