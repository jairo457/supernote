import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final _getStorage = GetStorage();
  final storagekey = 'isDarkMode';

  ThemeMode getThemeMode() {
    return isSaveDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool isSaveDarkMode() {
    return _getStorage.read(storagekey) ?? false;
  }

  void saveThemeMode(bool isDarkMode) {
    _getStorage.write(storagekey, isDarkMode);
  }

  void changeThemeMode() {
    Get.changeThemeMode(isSaveDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(!isSaveDarkMode());
  }
}
