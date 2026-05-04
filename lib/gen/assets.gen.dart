// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/cert.png
  AssetGenImage get cert => const AssetGenImage('assets/images/cert.png');

  /// File path: assets/images/profile.jpg
  AssetGenImage get profile => const AssetGenImage('assets/images/profile.jpg');

  /// File path: assets/images/skill.png
  AssetGenImage get skill => const AssetGenImage('assets/images/skill.png');

  /// List of all assets
  List<AssetGenImage> get values => [cert, profile, skill];
}

class $AssetsPdfGen {
  const $AssetsPdfGen();

  /// File path: assets/pdf/65011212240_D05_Thai.pdf
  String get a65011212240D05Thai => 'assets/pdf/65011212240_D05_Thai.pdf';

  /// File path: assets/pdf/CertSecondRound.pdf
  String get certSecondRound => 'assets/pdf/CertSecondRound.pdf';

  /// File path: assets/pdf/resume_new.pdf
  String get resumeNew => 'assets/pdf/resume_new.pdf';

  /// List of all assets
  List<String> get values => [a65011212240D05Thai, certSecondRound, resumeNew];
}

class MyAssets {
  const MyAssets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsPdfGen pdf = $AssetsPdfGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
