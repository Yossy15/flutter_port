import 'package:port/core/themes/app_color_extension.dart';
import 'package:flutter/material.dart';

extension ThemeGetter on BuildContext {
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>()!;
}
