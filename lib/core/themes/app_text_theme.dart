import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextsTheme extends ThemeExtension<AppTextsTheme> {
  const AppTextsTheme._internal({
    required this.headingLargeBold,
    required this.headingLarge,
    required this.headingLargeRegular,
    required this.headingMediumBold,
    required this.headingMedium,
    required this.headingMediumRegular,
    required this.bodyLargeBold,
    required this.bodyLarge,
    required this.bodyLargeRegular,
    required this.bodyMediumBold,
    required this.bodyMedium,
    required this.bodyMediumRegular,
    required this.bodySmallBold,
    required this.bodySmall,
    required this.bodySmallRegular,
  });

  final TextStyle headingLargeBold;
  final TextStyle headingLarge;
  final TextStyle headingLargeRegular;
  final TextStyle headingMediumBold;
  final TextStyle headingMedium;
  final TextStyle headingMediumRegular;
  final TextStyle bodyLargeBold;
  final TextStyle bodyLarge;
  final TextStyle bodyLargeRegular;
  final TextStyle bodyMediumBold;
  final TextStyle bodyMedium;
  final TextStyle bodyMediumRegular;
  final TextStyle bodySmallBold;
  final TextStyle bodySmall;
  final TextStyle bodySmallRegular;

  factory AppTextsTheme.main() => AppTextsTheme._internal(
        headingLargeBold: GoogleFonts.baiJamjuree(fontSize: 20, fontWeight: FontWeight.w700),
        headingLarge: GoogleFonts.baiJamjuree(fontSize: 20, fontWeight: FontWeight.w500),
        headingLargeRegular: GoogleFonts.baiJamjuree(fontSize: 20, fontWeight: FontWeight.w400),

        headingMediumBold: GoogleFonts.baiJamjuree(fontSize: 16, fontWeight: FontWeight.w700),
        headingMedium: GoogleFonts.baiJamjuree(fontSize: 16, fontWeight: FontWeight.w500),
        headingMediumRegular: GoogleFonts.baiJamjuree(fontSize: 16, fontWeight: FontWeight.w400),

        bodyLargeBold: GoogleFonts.baiJamjuree(fontSize: 16, fontWeight: FontWeight.w700),
        bodyLarge: GoogleFonts.baiJamjuree(fontSize: 16, fontWeight: FontWeight.w500),
        bodyLargeRegular: GoogleFonts.baiJamjuree(fontSize: 16, fontWeight: FontWeight.w400),

        bodyMediumBold: GoogleFonts.baiJamjuree(fontSize: 14, fontWeight: FontWeight.w700),
        bodyMedium: GoogleFonts.baiJamjuree(fontSize: 14, fontWeight: FontWeight.w500),
        bodyMediumRegular: GoogleFonts.baiJamjuree(fontSize: 14, fontWeight: FontWeight.w400),

        bodySmallBold: GoogleFonts.baiJamjuree(fontSize: 12, fontWeight: FontWeight.w700),
        bodySmall: GoogleFonts.baiJamjuree(fontSize: 12, fontWeight: FontWeight.w500),
        bodySmallRegular: GoogleFonts.baiJamjuree(fontSize: 12, fontWeight: FontWeight.w400),
      );

  // ✅ removed unused headingSmallBold getter that returned null

  @override
  AppTextsTheme copyWith({
    TextStyle? headingLargeBold,
    TextStyle? headingLarge,
    TextStyle? headingLargeRegular,
    TextStyle? headingMediumBold,
    TextStyle? headingMedium,
    TextStyle? headingMediumRegular,
    TextStyle? bodyLargeBold,
    TextStyle? bodyLarge,
    TextStyle? bodyLargeRegular,
    TextStyle? bodyMediumBold,
    TextStyle? bodyMedium,
    TextStyle? bodyMediumRegular,
    TextStyle? bodySmallBold,
    TextStyle? bodySmall,
    TextStyle? bodySmallRegular,
  }) {
    return AppTextsTheme._internal(
      headingLargeBold: headingLargeBold ?? this.headingLargeBold,
      headingLarge: headingLarge ?? this.headingLarge,
      headingLargeRegular: headingLargeRegular ?? this.headingLargeRegular,
      headingMediumBold: headingMediumBold ?? this.headingMediumBold,
      headingMedium: headingMedium ?? this.headingMedium,
      headingMediumRegular: headingMediumRegular ?? this.headingMediumRegular,
      bodyLargeBold: bodyLargeBold ?? this.bodyLargeBold,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyLargeRegular: bodyLargeRegular ?? this.bodyLargeRegular,
      bodyMediumBold: bodyMediumBold ?? this.bodyMediumBold,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodyMediumRegular: bodyMediumRegular ?? this.bodyMediumRegular,
      bodySmallBold: bodySmallBold ?? this.bodySmallBold,
      bodySmall: bodySmall ?? this.bodySmall,
      bodySmallRegular: bodySmallRegular ?? this.bodySmallRegular,
    );
  }

  @override
  AppTextsTheme lerp(covariant ThemeExtension<AppTextsTheme>? other, double t) {
    if (other is! AppTextsTheme) return this;

    return AppTextsTheme._internal(
      headingLargeBold: TextStyle.lerp(headingLargeBold, other.headingLargeBold, t)!,
      headingLarge: TextStyle.lerp(headingLarge, other.headingLarge, t)!,
      headingLargeRegular: TextStyle.lerp(headingLargeRegular, other.headingLargeRegular, t)!,
      headingMediumBold: TextStyle.lerp(headingMediumBold, other.headingMediumBold, t)!,
      headingMedium: TextStyle.lerp(headingMedium, other.headingMedium, t)!,
      headingMediumRegular: TextStyle.lerp(headingMediumRegular, other.headingMediumRegular, t)!,
      bodyLargeBold: TextStyle.lerp(bodyLargeBold, other.bodyLargeBold, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyLargeRegular: TextStyle.lerp(bodyLargeRegular, other.bodyLargeRegular, t)!,
      bodyMediumBold: TextStyle.lerp(bodyMediumBold, other.bodyMediumBold, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodyMediumRegular: TextStyle.lerp(bodyMediumRegular, other.bodyMediumRegular, t)!,
      bodySmallBold: TextStyle.lerp(bodySmallBold, other.bodySmallBold, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      bodySmallRegular: TextStyle.lerp(bodySmallRegular, other.bodySmallRegular, t)!,
    );
  }
}
