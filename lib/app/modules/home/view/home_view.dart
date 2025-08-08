import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/modules/about/view/about_me.dart';
import 'package:porfolio/app/modules/home/controllers/home_controller.dart';
import 'package:porfolio/app/modules/home/controllers/image_controller.dart';
import 'package:porfolio/app/modules/home/widgets/image_box.dart';
import 'package:porfolio/app/widgets/app_icon.dart';
import 'package:porfolio/app/widgets/nav_bar.dart';
import 'package:porfolio/app/widgets/status_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final ImageController imageController = Get.put(ImageController());

    return Obx(() {
      // If an app is opened
      if (controller.openedApp.value != null) {
        return SizedBox.expand(child: controller.openedApp.value!);
      }

      // Otherwise, show home screen
      return Column(
        children: [
          StatusBar(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 150, width: 130, child: ImageBox()),
                const SizedBox(width: 16),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      AppIcon(
                        label: 'About me',
                        imageAsset: 'assets/images/aboutme.jpg',
                        onTap:
                            () => controller.openApp(
                              AboutScreen(onBack: controller.closeApp),
                            ),
                      ),
                      AppIcon(
                        label: 'Tech Stack',
                        text: '🛠️',
                        onTap: () {
                          // You can open another widget here
                        },
                      ),
                      AppIcon(
                        label: 'Settings',
                        icon: Icons.settings_sharp,
                        onTap: () {
                          // Another widget here
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          NavBar(),
        ],
      );
    });
  }
}
