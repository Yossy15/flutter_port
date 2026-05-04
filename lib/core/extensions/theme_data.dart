import 'package:port/core/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:port/core/themes/app_color_extension.dart';
import 'package:port/core/themes/app_theme.dart';

extension AppThemeExtension on ThemeData {
  AppColorsExtension get appColors => AppTheme.arpelsColors;

  AppTextsTheme get appTexts => extension<AppTextsTheme>()!;
}
