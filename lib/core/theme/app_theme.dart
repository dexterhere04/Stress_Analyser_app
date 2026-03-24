import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF4A90A4);
  static const Color secondaryColor = Color(0xFF6BB5A2);
  static const Color backgroundColor = Color(0xFFF5F9FB);
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFE57373);

  static const Color calmColor = Color(0xFF81C784);
  static const Color moderateColor = Color(0xFFFFB74D);
  static const Color stressedColor = Color(0xFFE57373);

  static const Color positiveSentiment = Color(0xFF4CAF50);
  static const Color neutralSentiment = Color(0xFF9E9E9E);
  static const Color negativeSentiment = Color(0xFFF44336);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: Color(0xFF2C3E50),
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2C3E50),
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xFF2C3E50),
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF2C3E50),
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF2C3E50),
        ),
        bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF34495E)),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF7F8C8D)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: Color(0xFFBDC3C7),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }

  static Color getStressColor(double score) {
    if (score < 33) return calmColor;
    if (score < 66) return moderateColor;
    return stressedColor;
  }

  static String getStressLabel(double score) {
    if (score < 33) return 'Calm';
    if (score < 66) return 'Moderate';
    return 'Stressed';
  }
}
