// home_page_two.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/controllers/home_controller.dart';
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
      ],
    );
  }
}
