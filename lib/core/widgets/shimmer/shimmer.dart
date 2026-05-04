import 'package:flutter/material.dart';
import 'package:port/core/extensions/colors/app_color.dart';
import 'package:port/core/routes/app_route.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  AppShimmer({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.baseColor = const Color(0xFFE8E8E8),
    this.highlightColor = const Color(0xFFFAFAFA),
    this.customColor,
    this.customStops,
  }) : diameter = 0,
       child = Container(
         width: width,
         height: height,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(borderRadius),
           color: rootContext?.appColors.neutral.shade100,
         ),
       );

  AppShimmer.circle({
    super.key,
    required this.diameter,
    this.customColor,
    this.customStops,
  }) : width = null,
       height = null,
       borderRadius = 0,
       baseColor = const Color(0xFFE8E8E8),
       highlightColor = const Color(0xFFFAFAFA),
       child = CircleAvatar(
         radius: diameter / 2,
         backgroundColor: rootContext?.appColors.neutral.shade100,
       );

  final double? width;
  final double? height;
  final double borderRadius;

  final Widget child;
  final double diameter;
  final Color baseColor;
  final Color highlightColor;
  final List<Color>? customColor;
  final List<double>? customStops;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors:
            customColor ??
            [baseColor, baseColor, highlightColor, baseColor, baseColor],
        stops: customStops ?? const [0.0, 0.35, 0.5, 0.65, 1.0],
      ),
      child: child,
    );
  }
}
