import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porfolio/app/controllers/home_controller.dart';
import 'package:porfolio/app/widgets/app_page_wrapper.dart';
import 'package:porfolio/app/widgets/custom_appbar.dart';

class MiniGame extends StatelessWidget {
  const MiniGame({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPageWrapper(
      child: Column(
        children: [
          CustomAppBar(
            onBack: () => Get.find<HomeController>().closeApp(),
            appName: 'Mini Game',
            backgroundColor: Colors.black87,
          ),
          SizedBox(height: 80),
          Image.asset("assets/images/working.png"),
          Text(
            'Currently working on it!',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              letterSpacing: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
