import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/controllers/home_controller.dart';
import 'package:porfolio/app/modules/home/controllers/image_controller.dart';
import 'package:porfolio/app/modules/home/view/home_page_one.dart';
import 'package:porfolio/app/modules/home/view/home_page_two.dart';
import 'package:porfolio/app/modules/home/widgets/page_indicator.dart';
import 'package:porfolio/app/widgets/nav_bar.dart';
import 'package:porfolio/app/widgets/status_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    Get.put(ImageController());

    return Obx(() {
      if (controller.openedApp.value != null) {
        return SizedBox.expand(child: controller.openedApp.value!);
      }

      return Column(
        children: [
          StatusBar(),
          const SizedBox(height: 16),

          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              children: const [HomePageOne(), HomePageTwo()],
            ),
          ),

          const SizedBox(height: 12),

          PageIndicator(
            currentPage: _currentPage,
            pageCount: 2,
            onPageSelected: (index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),

          const SizedBox(height: 16),
          NavBar(),
        ],
      );
    });
  }
}
