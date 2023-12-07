import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:super_note/Screens/LoginScreen.dart';
import 'package:super_note/Widgets/CardBoard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  final data = [
    CardBoardData(
      title: "Hola se bienvenido "
          "A SuperNote",
      subtitle: "La mejor aplicacion de recordatorios que hay,.",
      image: const AssetImage("assets/B2/B2_Saludando.png"),
      backgroundColor: Color.fromARGB(255, 160, 209, 237),
      titleColor: Colors.pink,
      subtitleColor: const Color.fromARGB(255, 84, 76, 76),
      background: LottieBuilder.asset("assets/animation/bg-1.json"),
    ),
    CardBoardData(
      title: "¿Te quedas sin energias y no "
          "terminas tus tareas?",
      subtitle: "Tenemos la solucion.",
      image: const AssetImage("assets/B2/B2_Baja.png"),
      backgroundColor: Color.fromARGB(255, 242, 242, 205),
      titleColor: Colors.purple,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
      background: LottieBuilder.asset("assets/animation/zz.json"),
    ),
    CardBoardData(
      title: "Organiza todas tus tareas en un solo lugar",
      subtitle: "Nunca te volveras a perder de nada",
      image: const AssetImage("assets/B2/B2_Lista.png"),
      backgroundColor: Color.fromARGB(255, 232, 141, 169),
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animation/fire.json"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return CardBoard(data: data[index]);
        },
        onFinish: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
      ),
    );
  }
}
