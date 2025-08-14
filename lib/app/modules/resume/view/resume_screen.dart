import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/controllers/home_controller.dart';
import 'package:porfolio/app/widgets/app_page_wrapper.dart';
import 'package:porfolio/app/widgets/custom_appbar.dart';
import 'package:universal_html/html.dart' as html;

class ResumeScreen extends StatelessWidget {
  const ResumeScreen({super.key});

  void openResume() {
    html.window.open('assets/resume/Tanmay_resume.pdf', '_blank');
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
          SizedBox(height: 10),
          Center(
            child: Expanded(
              child: SingleChildScrollView(
                child: Image.asset(
                  'assets/resume/resume_preview.png',
                  height: 500,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: GestureDetector(
              child: Container(
                width: 125,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 3, right: 1, top: 1),
                  child: Text(
                    'View Full Resume',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              onTap: () {
                openResume();
              },
            ),
          ),
        ],
      ),
    );
  }
}
