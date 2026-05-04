import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.primary,
    required this.primarySurface,
    required this.primaryBorder,
    required this.primaryHover,
    required this.primaryPressed,
    required this.success,
    required this.warning,
    required this.error,
    required this.green,
    required this.pink,
    required this.purple,
    required this.neutral,
    required this.gradient,
  });

  final Color primary;
  final Color primarySurface;
  final Color primaryBorder;
  final Color primaryHover;
  final Color primaryPressed;
  final Color success;
  final Color warning;
  final Color error;
  final Color green;
  final Color pink;
  final Color purple;
  final ColorShades neutral;
  final LinearGradient gradient;

  @override
  AppColorsExtension copyWith({
    Color? primary,
    Color? primarySurface,
    Color? primaryBorder,
    Color? primaryHover,
    Color? primaryPressed,
    Color? success,
    Color? warning,
    Color? error,
    Color? green,
    Color? pink,
    Color? purple,
    ColorShades? neutral,
    LinearGradient? gradient,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      primarySurface: primarySurface ?? this.primarySurface,
      primaryBorder: primaryBorder ?? this.primaryBorder,
      primaryHover: primaryHover ?? this.primaryHover,
      primaryPressed: primaryPressed ?? this.primaryPressed,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      green: green ?? this.green,
      pink: pink ?? this.pink,
      purple: purple ?? this.purple,
      neutral: neutral ?? this.neutral,
      gradient: gradient ?? this.gradient,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;

    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      primarySurface: Color.lerp(primarySurface, other.primarySurface, t)!,
      primaryBorder: Color.lerp(primaryBorder, other.primaryBorder, t)!,
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      primaryPressed: Color.lerp(primaryPressed, other.primaryPressed, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      green: Color.lerp(green, other.green, t)!,       // ✅ fixed
      pink: Color.lerp(pink, other.pink, t)!,           // ✅ fixed
      purple: Color.lerp(purple, other.purple, t)!,     // ✅ fixed
      neutral: ColorShades.lerp(neutral, other.neutral, t),
      gradient: LinearGradient.lerp(gradient, other.gradient, t)!,
    );
  }
}

@immutable
class ColorShades {
  const ColorShades({
    required this.shade100,
    required this.shade90,
    required this.shade50,
    required this.shade40,
    required this.shade30,
    required this.shade20,
    required this.shade10,
  });

  final Color shade100;
  final Color shade90;
  final Color shade50;
  final Color shade40;
  final Color shade30;
  final Color shade20;
  final Color shade10;

  static ColorShades lerp(ColorShades a, ColorShades b, double t) {
    return ColorShades(
      shade100: Color.lerp(a.shade100, b.shade100, t)!,
      shade90: Color.lerp(a.shade90, b.shade90, t)!,
      shade50: Color.lerp(a.shade50, b.shade50, t)!,
      shade40: Color.lerp(a.shade40, b.shade40, t)!,
      shade30: Color.lerp(a.shade30, b.shade30, t)!,
      shade20: Color.lerp(a.shade20, b.shade20, t)!,
      shade10: Color.lerp(a.shade10, b.shade10, t)!,
    );
  }
}
