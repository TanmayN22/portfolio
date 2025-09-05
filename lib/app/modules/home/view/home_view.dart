import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:porfolio/app/controllers/home_controller.dart';
import 'package:porfolio/app/modules/home/controllers/image_controller.dart';
import 'package:porfolio/app/modules/home/view/home_page_one.dart';
import 'package:porfolio/app/modules/home/view/home_page_two.dart';
import 'package:porfolio/app/modules/home/widgets/page_indicator.dart';
import 'package:porfolio/app/modules/motiv/controller/motiv_controller.dart';
import 'package:porfolio/app/modules/motiv/widget/motiv_noti.dart';
import 'package:porfolio/app/widgets/nav_bar.dart';
import 'package:porfolio/app/widgets/status_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final motivController = Get.put(MotivController());
    Get.put(ImageController());

    return Stack(
      children: [
        // Layer 1: The main home screen UI. This is now always present.
        Column(
          children: [
            StatusBar(),
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int newPage) {
                  setState(() {
                    _currentPage = newPage;
                  });
                },
                children: const [HomePageOne(), HomePageTwo()],
              ),
            ),
            const SizedBox(height: 12),
            PageIndicator(
              currentPage: _currentPage,
              pageCount: 2,
              onPageSelected:
                  (index) => _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
            ),
            const SizedBox(height: 16),
            NavBar(),
          ],
        ),

        // Layer 2: The notification overlay
        Obx(() {
          final msg = motivController.currentNotification.value;
          if (msg != null) {
            return Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: NotificationOverlay(
                message: msg,
                onDismiss: motivController.dismissNotification,
              ),
            );
          }
          return const SizedBox.shrink();
        }),

        // Layer 3: The opened app, overlaid on top of the home screen
        Obx(() {
          if (controller.openedApp.value != null) {
            return SizedBox.expand(child: controller.openedApp.value!);
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
