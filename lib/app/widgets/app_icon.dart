import 'package:flutter/material.dart';
import 'package:porfolio/app/theme/styles.dart';

class AppIcon extends StatelessWidget {
  final IconData? icon; // Optional icon
  final String label;
  final VoidCallback onTap;
  final String? imageAsset; // Optional image

  const AppIcon({
    super.key,
    this.icon,
    required this.label,
    required this.onTap,
    this.imageAsset,
  }) : assert(
         icon != null || imageAsset != null,
         'Either icon or imageAsset must be provided',
       );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: AppStyles.glassEffect(theme.colorScheme.primary),
            padding: const EdgeInsets.all(12),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.9),
              child:
                  imageAsset != null
                      ? ClipOval(
                        child: Image.asset(
                          imageAsset!,
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        ),
                      )
                      : Icon(icon, size: 30, color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onBackground,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
