import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/controllers/home_controller.dart';
import 'package:porfolio/app/widgets/app_page_wrapper.dart';
import 'package:porfolio/app/widgets/custom_appbar.dart';
import 'package:universal_html/html.dart' as html;

class ResumeScreen extends StatelessWidget {
  const ResumeScreen({super.key});

  // Replaced the local asset path with your public Google Drive URL
  void openResume() {
    html.window.open('https://drive.google.com/file/d/1yR1okYe8lb7Z7HDj3FApldP3gOmvzLgZ/view?usp=drive_link', '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return AppPageWrapper(
      child: Column(
        children: [
          CustomAppBar(
            onBack: () => Get.find<HomeController>().closeApp(),
            appName: 'My Resume',
          ),
          const SizedBox(height: 10),
          // Removed the incorrect 'Expanded' widget
          Center(
            child: SingleChildScrollView(
              child: Image.asset(
                'assets/resume/resume_preview.png',
                height: 500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: openResume,
            child: Container(
              width: 150,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: const Center(
                child: Text(
                  'View Full Resume',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}