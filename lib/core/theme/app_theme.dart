import 'package:flutter/material.dart';

class AppTheme {
  // Educational/School-themed Light theme colors
  // Primary: Deep Blue (Trust, Knowledge, Education)
  static const Color primaryColor = Color(0xFF1E3A8A); // Deep educational blue
  // Secondary: Warm White/Cream (Clean, Fresh)
  static const Color secondaryColor = Color(0xFFFAFAFA); // Soft white
  // Accent: Sky Blue (Learning, Growth)
  static const Color accentColor = Color(0xFF3B82F6); // Bright blue
  // Success: Forest Green (Achievement, Progress)
  static const Color successColor = Color(0xFF10B981); // Emerald green
  // Warning: Amber (Attention, Caution)
  static const Color warningColor = Color(0xFFF59E0B); // Amber
  // Error: Coral Red (Important alerts)
  static const Color errorColor = Color(0xFFEF4444); // Red
  // Info: Teal (Information, Guidance)
  static const Color infoColor = Color(0xFF14B8A6); // Teal

  // Educational/School-themed Dark theme colors
  // Primary: Light Blue (Bright, Clear)
  static const Color darkPrimaryColor = Color(0xFF60A5FA); // Light blue
  // Secondary: Dark Blue-Grey (Professional, Calm)
  static const Color darkSecondaryColor = Color(0xFF0F172A); // Slate dark
  // Accent: Cyan (Modern, Tech)
  static const Color darkAccentColor = Color(0xFF06B6D4); // Cyan
  // Success: Emerald (Positive, Growth)
  static const Color darkSuccessColor = Color(0xFF34D399); // Emerald
  // Warning: Amber (Same as light)
  static const Color darkWarningColor = Color(0xFFF59E0B); // Amber
  // Error: Rose (Softer error in dark mode)
  static const Color darkErrorColor = Color(0xFFF87171); // Rose red
  // Info: Teal (Same as light)
  static const Color darkInfoColor = Color(0xFF2DD4BF); // Teal

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Cairo',
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: secondaryColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: primaryColor,
        onError: Colors.white,
        tertiary: infoColor,
        onTertiary: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 1.5),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
        filled: true,
        fillColor: secondaryColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        labelStyle: TextStyle(
          fontFamily: 'Cairo',
          color: accentColor.withOpacity(0.7),
        ),
        hintStyle: TextStyle(
          fontFamily: 'Cairo',
          color: accentColor.withOpacity(0.7),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: secondaryColor,
        shadowColor: primaryColor.withOpacity(0.1),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        titleSmall: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: primaryColor,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: primaryColor,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: primaryColor,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: primaryColor,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: primaryColor,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: primaryColor,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Cairo',
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: darkPrimaryColor,
        secondary: darkAccentColor,
        surface: darkSecondaryColor,
        error: darkErrorColor,
        onPrimary: Colors.white,
        onSecondary: darkSecondaryColor,
        onSurface: darkPrimaryColor,
        onError: darkSecondaryColor,
        tertiary: darkInfoColor,
        onTertiary: darkSecondaryColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkSecondaryColor,
        foregroundColor: darkPrimaryColor,
        iconTheme: const IconThemeData(
          color: darkPrimaryColor,
          size: 24,
        ),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkPrimaryColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimaryColor,
          foregroundColor: darkSecondaryColor,
          elevation: 2,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkPrimaryColor,
          side: const BorderSide(color: darkPrimaryColor, width: 1.5),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkPrimaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkAccentColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkAccentColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkPrimaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkErrorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkErrorColor, width: 2),
        ),
        filled: true,
        fillColor: darkSecondaryColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        labelStyle: const TextStyle(
          fontFamily: 'Cairo',
          color: darkAccentColor,
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Cairo',
          color: darkAccentColor,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: const Color(0xFF1E293B), // Slate-800 for better contrast
        shadowColor: darkPrimaryColor.withOpacity(0.1),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: darkPrimaryColor,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: darkPrimaryColor,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: darkPrimaryColor,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: darkPrimaryColor,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkPrimaryColor,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: darkPrimaryColor,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: darkPrimaryColor,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: darkPrimaryColor,
        ),
        titleSmall: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: darkPrimaryColor,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: darkPrimaryColor,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: darkPrimaryColor,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: darkPrimaryColor,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: darkPrimaryColor,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: darkPrimaryColor,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: darkPrimaryColor,
        ),
      ),
      scaffoldBackgroundColor: darkSecondaryColor,
    );
  }
}
