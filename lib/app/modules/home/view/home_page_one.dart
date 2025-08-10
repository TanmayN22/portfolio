// home_page_one.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/modules/about/view/about_me.dart';
import 'package:porfolio/app/controllers/home_controller.dart';
import 'package:porfolio/app/modules/home/widgets/image_box.dart';
import 'package:porfolio/app/modules/resume/view/resume_screen.dart';
import 'package:porfolio/app/widgets/app_icon.dart';

class HomePageOne extends StatelessWidget {
  const HomePageOne({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Padding(
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
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                AppIcon(
                  label: 'About me',
                  imageAsset: 'assets/images/aboutme.jpg',
                  onTap: () => controller.openApp(AboutScreen()),
                ),
                AppIcon(label: 'Tech Stack', text: '🛠️', onTap: () {}),
                AppIcon(
                  label: 'Resume',
                  icon: Icons.insert_drive_file,
                  onTap: () => controller.openApp(ResumeScreen()),
                ),
                AppIcon(label: 'Projects', icon: Icons.work, onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
