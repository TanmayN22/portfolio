import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onBack;
  final String appName;
  final Color backgroundColor;

  const CustomAppBar({
    super.key,
    required this.onBack,
    required this.appName,
    this.backgroundColor = const Color.fromARGB(255, 1, 78, 141),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: backgroundColor,
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
          Text(
            appName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
