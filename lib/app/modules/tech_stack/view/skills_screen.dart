import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/controllers/home_controller.dart';
import 'package:porfolio/app/modules/tech_stack/widgets/skills_globe_widget.dart';
import 'package:porfolio/app/widgets/app_page_wrapper.dart';
import 'package:porfolio/app/widgets/custom_appbar.dart';

class SkillsGlobeScreen extends StatelessWidget {
  const SkillsGlobeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.white;

    return AppPageWrapper(
      child: Container(
        color: backgroundColor, // Theme-aware background
        child: Column(
          children: [
            CustomAppBar(
              onBack: () => Get.find<HomeController>().closeApp(),
              appName: 'Tech Stack',
              backgroundColor: Colors.grey,
            ),

            // Full screen globe with theme-aware background
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: backgroundColor,
                child: const Center(child: SkillsGlobeWidget()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
