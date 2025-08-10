import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var openedApp = Rx<Widget?>(null);

  void openApp(Widget app) {
    openedApp.value = app;
  }

  void closeApp() {
    openedApp.value = null;
  }
}
