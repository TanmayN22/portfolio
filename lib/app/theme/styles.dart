import 'package:flutter/material.dart';

class AppStyles {
  static const double borderRadius = 20;

  // General Styles
  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
  );

  static BoxDecoration appBox({Color color = const Color(0xFF1F1F1F)}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static BoxDecoration glassEffect(Color borderColor) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.05),
          Colors.white.withOpacity(0.02),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor.withOpacity(0.2),
        width: 1.2,
      ),
    );
  }
}
