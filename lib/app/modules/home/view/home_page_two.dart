// home_page_two.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/controllers/home_controller.dart';
import 'package:porfolio/app/modules/home/widgets/music_widget.dart';
import 'package:porfolio/app/modules/projects/model/project_model.dart';
import 'package:porfolio/app/modules/projects/widgets/project_details_view.dart.dart';
// import 'package:porfolio/app/modules/mail/view/mail_view.dart';
import 'package:porfolio/app/widgets/app_icon.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:porfolio/app/data/services/url_launcher.dart';

class HomePageTwo extends StatelessWidget {
  HomePageTwo({super.key});

  final homestockProject = Project(
    name: 'HomeStock',
    iconPath: 'assets/icons/homestock.png',
    githuburl: 'https://github.com/TanmayN22/HomeStock',
    accentColor: const Color.fromARGB(255, 255, 139, 7),
    imagePaths: [
      'assets/images/hs_1.png',
      'assets/images/hs_2.png',
      'assets/images/hs_3.png',
      'assets/images/hs_4.png',
    ],
    description:
        '''Tired of finding expired food in the back of your fridge? Ever get to the grocery store and forget what you actually need?
Say goodbye to kitchen chaos with HomeStock, your personal pantry assistant! Designed to be simple and intuitive, HomeStock helps you easily keep track of every item in your pantry, fridge, and cupboards. Get smart alerts before food goes bad, create shopping lists in seconds, and finally put an end to wasteful spending.
Take control of your kitchen inventory and transform the way you shop and save!
Why you'll love HomeStock:

🍎 Know Your Stock in Seconds
🗓️ Stop Food Waste & Save Money
🛒 Build Smarter Shopping Lists
🔎 Find Anything, Fast
📊 Real-Time Quantity Tracking
🗑️ Track Your Consumption.''',
    status: ProjectStatus.completed,
    techStack: {
      'Flutter': 'assets/icons/light/flutter.svg',
      'Sqlite': 'assets/icons/light/sqlite.svg',
      'Dart': 'assets/icons/light/dart.svg',
      'Getx': 'assets/icons/getx.svg',
    },
  );

  final quizzlerProject = Project(
    name: 'Quizzler',
    iconPath: 'assets/icons/quizzler.png',
    githuburl: 'https://github.com/TanmayN22/Quizzler',
    accentColor: const Color.fromARGB(255, 94, 2, 160),
    imagePaths: [
      'assets/images/q_1.png',
      'assets/images/q_2.png',
      'assets/images/q_3.png',
      'assets/images/q_4.png',
      'assets/images/q_5.png',
      'assets/images/q_6.png',
    ],
    description:
        '''Struggling with one-size-fits-all study methods? Unlock your true learning potential with Quizzler, the AI-powered learning app that adapts to you.
Quizzler is designed to revolutionize your study sessions. Our advanced AI creates a truly personalized experience, identifying your strengths and targeting your weaknesses with dynamic quizzes and tailored learning paths. Whether you're preparing for an exam or mastering a new skill, Quizzler provides the tools you need to learn smarter, not just harder.
Experience a new era of education, right in your pocket.

Key Features:
🎯 Adaptive Quizzes That Learn With You
🗺️ Receive custom recommendations for resources and exercises 
🧘 Deep Focus Mode
🔒 Secure & Fair Exam Mode
💡 AI-Powered Insights & Feedback

Stop just studying. 
Start learning intelligently.
Download Quizzler today!''',
    status: ProjectStatus.updating,
    techStack: {
      'Flutter': 'assets/icons/light/flutter.svg',
      'Firebase': 'assets/icons/light/firebase.svg',
      'Dart': 'assets/icons/light/dart.svg',
      'GetX': 'assets/icons/getx.svg',
      'Sqlite': 'assets/icons/light/sqlite.svg',
    },
  );

  final tiledProject = Project(
    name: 'Tiled',
    iconPath: 'assets/icons/tiled.png',
    githuburl: 'https://github.com/TanmayN22/Tiled',
    accentColor: const Color.fromARGB(255, 82, 80, 80),
    imagePaths: [
      'assets/images/t_1.png',
      'assets/images/t_2.png',
      'assets/images/t_3.png',
      'assets/images/t_4.png',
      'assets/images/t_5.png',
      'assets/images/t_6.png',
    ],
    description:
        '''Tiled is a modern gallery app that reimagines how users interact with their photo collections. Built using Flutter and Dart, this project demonstrates proficiency in mobile application development with a focus on intuitive navigation, powerful search capabilities, and intelligent file organization.

Key Features:
Advanced Navigation System: Fluid, gesture-based navigation that makes browsing through large photo collections effortless

Smart Search Functionality: Robust search features that help users quickly locate specific images or albums

Responsive UI Design: Card-based interface and responsive layouts that adapt seamlessly across different screen sizes
''',
    status: ProjectStatus.inProgress,
    techStack: {
      'Flutter': 'assets/icons/light/flutter.svg',
      'Dart': 'assets/icons/light/dart.svg',
      'GetX': 'assets/icons/getx.svg',
      'Hive': 'assets/icons/light/flutter.svg',
    },
  );

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              AppIcon(
                label: 'Instagram',
                icon: Bootstrap.instagram,
                onTap:
                    () => UrlLauncher.launchURL(
                      'https://instagram.com/cons.tan22',
                    ),
              ),
              AppIcon(
                label: 'Linkedin',
                icon: Bootstrap.linkedin,
                onTap:
                    () => UrlLauncher.launchURL(
                      'https://www.linkedin.com/in/tanmay-nayak-272532261/',
                    ),
              ),
              AppIcon(
                label: 'Github',
                icon: Bootstrap.github,
                onTap:
                    () => UrlLauncher.launchURL('https://github.com/TanmayN22'),
              ),
              AppIcon(
                label: 'Mail',
                icon: Icons.mail,
                onTap:
                    () =>
                        UrlLauncher.launchURL('mailto:nayaktanmayg@gmail.com'),
                // () => controller.openApp(ContactMeScreen()),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        MusicWidget(),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              AppIcon(
                label: 'HomeStock',
                imageAsset: 'assets/icons/homestock.png',
                onTap:
                    () => controller.openApp(
                      ProjectDetailsView(project: homestockProject),
                    ),
              ),
              AppIcon(
                label: 'Quizzler',
                imageAsset: 'assets/icons/quizzler.png',
                onTap:
                    () => controller.openApp(
                      ProjectDetailsView(project: quizzlerProject),
                    ),
              ),
              AppIcon(
                label: 'Tiled',
                imageAsset: 'assets/icons/tiled.png',
                onTap:
                    () => controller.openApp(
                      ProjectDetailsView(project: tiledProject),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
