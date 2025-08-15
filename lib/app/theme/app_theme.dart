import 'package:flutter/material.dart';

class AppTheme {
  // Shared colors
  static const primaryColor = Color(0xFF1F1F1F);
  static const secondaryColor = Color(0xFF2E2E2E);
  static const accentColor = Color(0xFF4FC3F7); // Cyan accent
  static const cardRadius = 20.0;

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.grey[100],
      primaryColor: Colors.white,
      cardColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ), // Ensures icons are visible
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ), // Ensures body text is visible
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black, // Ensures titles are visible
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color.fromARGB(255, 81, 80, 80),
      primaryColor: primaryColor,
      cardColor: secondaryColor,
      iconTheme: const IconThemeData(
        color: Color.fromARGB(255, 123, 123, 123),
      ), // Ensures icons are visible
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white, // Ensures app bar elements are visible
        elevation: 0,
      ),
      useMaterial3: true,
    );
  }
}
