// home_page_two.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/controllers/home_controller.dart';
import 'package:porfolio/app/modules/home/widgets/music_widget.dart';
import 'package:porfolio/app/modules/projects/homestock/view/homestock_view.dart';
import 'package:porfolio/app/modules/projects/quizzler/view/quizzler_view.dart';
import 'package:porfolio/app/modules/projects/tiled/view/tiled_view.dart';
// import 'package:porfolio/app/modules/mail/view/mail_view.dart';
import 'package:porfolio/app/widgets/app_icon.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:porfolio/app/data/services/url_launcher.dart';

class HomePageTwo extends StatelessWidget {
  const HomePageTwo({super.key});

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
                onTap: () => controller.openApp(HomestockView()),
              ),
              AppIcon(
                label: 'Quizzler',
                imageAsset: 'assets/icons/quizzler.png',
                onTap: () => controller.openApp(QuizzlerView()),
              ),
              AppIcon(
                label: 'Tiled',
                imageAsset: 'assets/icons/tiled.png',
                onTap: () => controller.openApp(TiledView()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
