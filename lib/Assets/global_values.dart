import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class GlobalValues {
  static ValueNotifier<bool> DarkTheme = ValueNotifier<bool>(true);
  static ValueNotifier<bool> LightTheme = ValueNotifier<bool>(true);
  static Rx<bool> flagNote = true.obs;
  //Valor que cmabiara para actualizar la vita de las tareas
}
