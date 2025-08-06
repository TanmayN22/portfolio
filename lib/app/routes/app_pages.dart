import 'package:get/get.dart';
import 'package:porfolio/app/modules/home/home_view.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.HOME;

  static final routes = [
    GetPage(name: Routes.HOME, page: () => const HomeScreen()),
    // GetPage(
    //   name: Routes.ABOUT,
    //   page: () => const AboutScreen(),
    // ),
    // GetPage(
    //   name: Routes.TECH_STACK,
    //   page: () => const TechStackScreen(),
    // ),
    // GetPage(
    //   name: Routes.RESUME,
    //   page: () => const ResumeScreen(),
    // ),
    // GetPage(
    //   name: Routes.PROJECT1,
    //   page: () => const Project1Screen(),
    // ),
    // GetPage(
    //   name: Routes.PROJECT2,
    //   page: () => const Project2Screen(),
    // ),
    // GetPage(
    //   name: Routes.AI_ASSISTANT,
    //   page: () => const AIAssistantScreen(),
    // ),
    // Add more pages here...
  ];
}
