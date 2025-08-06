import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/controllers/theme_controller.dart';
import 'package:porfolio/app/modules/home/home_view.dart';

class Wallpaper extends StatelessWidget {
  const Wallpaper({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: themeController.toggleTheme,
            icon: Obx(
              () => Icon(
                themeController.isDarkMode.value
                    ? Icons.wb_sunny
                    : Icons.nightlight_round,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Center(
          child: Container(
            height: 700,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              image: const DecorationImage(
                image: AssetImage('assets/images/wallpaper1.jpeg'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.8), blurRadius: 10),
              ],
              border: Border.all(color: Colors.black, width: 8),
            ),
            child: HomeScreen(),
          ),
        ),
      ),
    );
  }
}
