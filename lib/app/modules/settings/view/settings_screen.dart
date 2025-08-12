import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/controllers/home_controller.dart';
import 'package:porfolio/app/controllers/theme_controller.dart';
import 'package:porfolio/app/widgets/app_page_wrapper.dart';
import 'package:porfolio/app/widgets/custom_appbar.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;

    return AppPageWrapper(
      child: Column(
        children: [
          CustomAppBar(
            onBack: () => Get.find<HomeController>().closeApp(),
            appName: 'Settings',
          ),
          IconButton(
            onPressed: themeController.toggleTheme,
            icon: Obx(() {
              final isDark = themeController.isDarkMode.value;
              return Icon(
                isDark ? Icons.wb_sunny : Icons.nightlight_round,
                color:
                    isDark
                        ? Colors.black
                        : Colors
                            .black, // Sun icon always black, moon icon black as well
              );
            }),
          ),
        ],
      ),
    );
  }
}
