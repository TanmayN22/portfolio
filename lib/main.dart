import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/modules/home/widgets/wallpaper.dart';
import 'package:porfolio/app/routes/app_pages.dart';
import 'app/controllers/theme_controller.dart';

void main() {
  runApp(MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Tanmay's Portfolio",
        theme: themeController.theme,
        home: const Wallpaper(),
        getPages: AppPages.routes,
      ),
    );
  }
}
