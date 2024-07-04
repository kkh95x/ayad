/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsCaptchaImagesGen {
  const $AssetsCaptchaImagesGen();

  /// File path: assets/captcha_images/image1.jpg
  AssetGenImage get image1 =>
      const AssetGenImage('assets/captcha_images/image1.jpg');

  /// File path: assets/captcha_images/image2.jpeg
  AssetGenImage get image2 =>
      const AssetGenImage('assets/captcha_images/image2.jpeg');

  /// File path: assets/captcha_images/image3.jpg
  AssetGenImage get image3 =>
      const AssetGenImage('assets/captcha_images/image3.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [image1, image2, image3];
}

class $AssetsJsonGen {
  const $AssetsJsonGen();

  /// File path: assets/json/login.json
  String get login => 'assets/json/login.json';

  /// List of all assets
  List<String> get values => [login];
}

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/background.png
  AssetGenImage get background =>
      const AssetGenImage('assets/png/background.png');

  /// File path: assets/png/group_default.jpg
  AssetGenImage get groupDefault =>
      const AssetGenImage('assets/png/group_default.jpg');

  /// File path: assets/png/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/png/logo.png');

  /// File path: assets/png/logo_s.png
  AssetGenImage get logoS => const AssetGenImage('assets/png/logo_s.png');

  /// File path: assets/png/logo_white.png
  AssetGenImage get logoWhite =>
      const AssetGenImage('assets/png/logo_white.png');

  /// File path: assets/png/logo_white_s.png
  AssetGenImage get logoWhiteS =>
      const AssetGenImage('assets/png/logo_white_s.png');

  /// File path: assets/png/person.png
  AssetGenImage get person => const AssetGenImage('assets/png/person.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [background, groupDefault, logo, logoS, logoWhite, logoWhiteS, person];
}

class $AssetsScreenGen {
  const $AssetsScreenGen();

  /// File path: assets/screen/1.jpeg
  AssetGenImage get a1 => const AssetGenImage('assets/screen/1.jpeg');

  /// File path: assets/screen/2.jpeg
  AssetGenImage get a2 => const AssetGenImage('assets/screen/2.jpeg');

  /// File path: assets/screen/3.jpeg
  AssetGenImage get a3 => const AssetGenImage('assets/screen/3.jpeg');

  /// File path: assets/screen/4.jpeg
  AssetGenImage get a4 => const AssetGenImage('assets/screen/4.jpeg');

  /// List of all assets
  List<AssetGenImage> get values => [a1, a2, a3, a4];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/loading.json
  String get loading => 'assets/svg/loading.json';

  /// File path: assets/svg/map.svg
  String get map => 'assets/svg/map.svg';

  /// File path: assets/svg/need_update.json
  String get needUpdate => 'assets/svg/need_update.json';

  /// File path: assets/svg/whatsapp-white-icon.svg
  String get whatsappWhiteIcon => 'assets/svg/whatsapp-white-icon.svg';

  /// List of all assets
  List<String> get values => [loading, map, needUpdate, whatsappWhiteIcon];
}

class Assets {
  Assets._();

  static const $AssetsCaptchaImagesGen captchaImages =
      $AssetsCaptchaImagesGen();
  static const $AssetsJsonGen json = $AssetsJsonGen();
  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsScreenGen screen = $AssetsScreenGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
