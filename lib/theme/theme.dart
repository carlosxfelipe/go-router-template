import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  // Light
  static const primaryLight = Color(0xFF18181B);
  static const onPrimaryLight = Colors.white;
  static const secondaryLight = Color(0xFFF4F4F5);
  static const onSecondaryLight = Colors.black;
  static const surfaceLight = Color(0xFFFFFFFF);
  static const scaffoldBackgroundLight = Color(0xFFFFFFFF);

  // Dark
  static const primaryDark = Color(0xFFF4F4F5);
  static const onPrimaryDark = Color(0xFF09090B);
  static const secondaryDark = Color(0xFF18181B);
  static const onSecondaryDark = Colors.white;
  static const surfaceDark = Color(0xFF0F172A);
  static const scaffoldBackgroundDark = Color(0xFF020817);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryLight,
        onPrimary: AppColors.onPrimaryLight,
        secondary: AppColors.secondaryLight,
        onSecondary: AppColors.onSecondaryLight,
        surface: AppColors.surfaceLight,
        onSurface: Colors.black,
        outlineVariant: Colors.grey.shade300,
      ),
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceLight,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryDark,
        onPrimary: AppColors.onPrimaryDark,
        secondary: AppColors.secondaryDark,
        onSecondary: AppColors.onSecondaryDark,
        surface: AppColors.surfaceDark,
        onSurface: Colors.white,
        outlineVariant: Colors.grey.shade700,
      ),
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
    );
  }

  static void setSystemUIOverlayStyle(Brightness brightness, {String? route}) {
    final isDark = brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
      ),
    );
  }
}
