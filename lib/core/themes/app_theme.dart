import 'package:port/core/themes/app_color_extension.dart';
import 'package:port/core/themes/app_text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  /// Light theme data of the app
  static ThemeData getTheme() {
    final AppColorsExtension colorSet = arpelsColors;

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colorSet.primary,
        primary: colorSet.primary,
        brightness: Brightness.light,
      ),
      splashFactory: NoSplash.splashFactory,
      extensions: [colorSet, appTextTheme],
    );
  }

  static final arpelsColors = const AppColorsExtension(
    // ✅ added const
    primary: Color(0xFF3C82F6),
    primarySurface: Color(0xFFEBF2FE),
    primaryBorder: Color(0xFF9ABEFA),
    primaryHover: Color(0xFF0A5ADE),
    primaryPressed: Color(0xFF06398C),
    success: Color(0xFF1DC18E),
    warning: Color(0xFFFDC948),
    error: Color(0xFFDB1F22),
    green: Color(0xFF2E7D32),
    pink: Color(0xFFD81B60),
    purple: Color(0xFF5E35B1),
    neutral: ColorShades(
      shade100: Color(0xFF000000),
      shade90: Color(0xFF2B2B2D),
      shade50: Color(0xFF999999),
      shade40: Color(0xFFD9D9D9),
      shade30: Color(0xFFF4F6F9),
      shade20: Color(0xFFFCFBFC),
      shade10: Color(0xFFFFFFFF),
    ),
    gradient: LinearGradient(
      colors: [Color(0xFF3C82F6), Color(0xFF9ABEFA)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );

  static final appTextTheme = AppTextsTheme.main();
}
