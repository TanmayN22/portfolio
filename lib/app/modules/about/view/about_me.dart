import 'package:flutter/material.dart';
import 'package:porfolio/app/modules/about/widgets/body.dart';
import 'package:porfolio/app/widgets/app_page_wrapper.dart';

class AboutScreen extends StatelessWidget {
  final VoidCallback onBack;
  const AboutScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppPageWrapper(
      child: Column(
        children: [
          // Top bar
          Container(
            height: 44,
            color: const Color.fromARGB(255, 1, 78, 141),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: onBack,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 8),
                const Text(
                  'About Me',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Body(),
        ],
      ),
    );
  }
}
