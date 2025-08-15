import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData? icon; // Optional icon
  final String label; // Text below the circle
  final VoidCallback onTap;
  final String? imageAsset; // Optional image inside the circle
  final String? text; // Optional text inside the circle

  const AppIcon({
    super.key,
    this.icon,
    required this.label,
    required this.onTap,
    this.imageAsset,
    this.text,
  }) : assert(
         icon != null || imageAsset != null || text != null,
         'Either icon, imageAsset, or text must be provided',
       );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final circleBgColor = isDark ? Colors.black : Colors.white;
    final iconColor = isDark ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: onTap,
      child: FittedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: CircleAvatar(
                radius: 70,
                backgroundColor: circleBgColor,
                child:
                    imageAsset != null
                        ? ClipOval(
                          child: Image.asset(
                            imageAsset!,
                            fit: BoxFit.cover,
                            height: 150,
                            width: 150,
                          ),
                        )
                        : text != null
                        ? Text(
                          text!,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 80,
                            color: iconColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )
                        : Icon(icon, size: 80, color: iconColor),
              ),
            ),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(fontSize: 35, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
