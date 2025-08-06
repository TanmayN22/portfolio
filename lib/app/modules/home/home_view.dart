import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/controllers/theme_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Obx(
              () => Icon(
                themeController.isDarkMode.value
                    ? Icons.wb_sunny
                    : Icons.nightlight_round,
              ),
            ),
            onPressed: themeController.toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Wallpaper(),
      ),
    );
  }
}

class Wallpaper extends StatelessWidget {
  const Wallpaper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          image: AssetImage('assets/images/wallpaper2.jpeg'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 20),
        ],
        border: Border.all(color: Colors.black, width: 10),
      ),
      child: const Center(),
    );
  }
}
