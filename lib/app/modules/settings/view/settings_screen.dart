import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/controllers/home_controller.dart';
import 'package:porfolio/app/controllers/theme_controller.dart';
import 'package:porfolio/app/widgets/app_page_wrapper.dart';
import 'package:porfolio/app/widgets/custom_appbar.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return AppPageWrapper(
      backgroundColor: Theme.of(context).primaryColor,
      child: Column(
        children: [
          CustomAppBar(
            onBack:
                () =>
                    Get.find<HomeController>()
                        .closeApp(), // Standard navigation
            appName: 'Settings',
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.brightness_6,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: Text(
                    'Dark Mode',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  trailing: Obx(
                    () => Switch(
                      value: themeController.isDarkMode.value,
                      onChanged: (value) => themeController.toggleTheme(),
                      activeColor:
                          Colors
                              .black, // Color of the thumb when the switch is on
                      activeTrackColor:
                          Colors
                              .white, // Color of the track when the switch is on
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
