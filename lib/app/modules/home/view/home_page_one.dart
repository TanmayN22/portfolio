import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/modules/about/view/about_me.dart';
import 'package:porfolio/app/controllers/home_controller.dart';
import 'package:porfolio/app/modules/analytics/view/analytics_view.dart';
import 'package:porfolio/app/modules/assistant/view/assistant_view.dart';
import 'package:porfolio/app/modules/game/view/mini_game.dart';
import 'package:porfolio/app/modules/home/widgets/github_widget.dart';
import 'package:porfolio/app/modules/home/widgets/image_box.dart';
import 'package:porfolio/app/modules/motiv/controller/motiv_controller.dart';
import 'package:porfolio/app/modules/resume/view/resume_screen.dart';
import 'package:porfolio/app/modules/settings/view/settings_screen.dart';
import 'package:porfolio/app/modules/tech_stack/view/skills_screen.dart';
import 'package:porfolio/app/widgets/app_icon.dart';
import 'package:porfolio/data/services/secrets.dart';

class HomePageOne extends StatelessWidget {
  const HomePageOne({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final motivController = Get.find<MotivController>(); // Get motiv controller

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
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
                    AppIcon(
                      label: 'Tech Stack',
                      icon: Icons.handyman_outlined,
                      onTap: () => controller.openApp(SkillsGlobeScreen()),
                    ),
                    AppIcon(
                      label: 'Resume',
                      icon: Icons.insert_drive_file,
                      onTap: () => controller.openApp(ResumeScreen()),
                    ),
                    AppIcon(
                      label: 'My Assistant',
                      icon: Icons.blur_on,
                      onTap:
                          () => controller.openApp(
                            AssistantView(),
                          ), // Fixed syntax
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    AppIcon(
                      label: 'Settings',
                      icon: Icons.settings,
                      onTap: () => controller.openApp(Settings()),
                    ),
                    AppIcon(
                      label: 'My Analytics',
                      icon: Icons.bar_chart_rounded,
                      onTap: () => controller.openApp(AnalyticsView()),
                    ),
                    AppIcon(
                      label: 'Mini Game',
                      icon: Icons.videogame_asset_outlined,
                      onTap: () => controller.openApp(MiniGame()),
                    ),
                    AppIcon(
                      label: 'Motiv',
                      icon: Icons.format_quote_sharp,
                      onTap:
                          () => motivController.showRandomQuote(), // Clean call
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                height: 150,
                width: 130,
                child: Image.asset('assets/images/map.png'),
              ),
            ],
          ),
          const SizedBox(height: 25),
          GitHubContributionsWidget(username: 'TanmayN22', token: githubToken),
        ],
      ),
    );
  }
}
