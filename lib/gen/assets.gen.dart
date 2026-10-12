// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/EG.png
  AssetGenImage get eg => const AssetGenImage('assets/icons/EG.png');

  /// File path: assets/icons/LR.png
  AssetGenImage get lr => const AssetGenImage('assets/icons/LR.png');

  /// File path: assets/icons/change_password.svg
  String get changePassword => 'assets/icons/change_password.svg';

  /// File path: assets/icons/email_icon.svg
  String get emailIcon => 'assets/icons/email_icon.svg';

  /// File path: assets/icons/google.png
  AssetGenImage get google => const AssetGenImage('assets/icons/google.png');

  /// File path: assets/icons/name_icon.svg
  String get nameIcon => 'assets/icons/name_icon.svg';

  /// File path: assets/icons/password_icon.svg
  String get passwordIcon => 'assets/icons/password_icon.svg';

  /// List of all assets
  List<dynamic> get values => [
    eg,
    lr,
    changePassword,
    emailIcon,
    google,
    nameIcon,
    passwordIcon,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/Logo.png');

  /// File path: assets/images/birthday.png
  AssetGenImage get birthday =>
      const AssetGenImage('assets/images/birthday.png');

  /// File path: assets/images/birthday_dark.png
  AssetGenImage get birthdayDark =>
      const AssetGenImage('assets/images/birthday_dark.png');

  /// File path: assets/images/book_club.png
  AssetGenImage get bookClub =>
      const AssetGenImage('assets/images/book_club.png');

  /// File path: assets/images/book_club_dark.png
  AssetGenImage get bookClubDark =>
      const AssetGenImage('assets/images/book_club_dark.png');

  /// File path: assets/images/evently_dark.png
  AssetGenImage get eventlyDark =>
      const AssetGenImage('assets/images/evently_dark.png');

  /// File path: assets/images/exhibition.png
  AssetGenImage get exhibition =>
      const AssetGenImage('assets/images/exhibition.png');

  /// File path: assets/images/exhibition_dark.png
  AssetGenImage get exhibitionDark =>
      const AssetGenImage('assets/images/exhibition_dark.png');

  /// File path: assets/images/gamming.png
  AssetGenImage get gamming => const AssetGenImage('assets/images/gamming.png');

  /// File path: assets/images/logo_dark.png
  AssetGenImage get logoDark =>
      const AssetGenImage('assets/images/logo_dark.png');

  /// File path: assets/images/logo_img.png
  AssetGenImage get logoImg =>
      const AssetGenImage('assets/images/logo_img.png');

  /// File path: assets/images/meeting.png
  AssetGenImage get meeting => const AssetGenImage('assets/images/meeting.png');

  /// File path: assets/images/meeting_dark.png
  AssetGenImage get meetingDark =>
      const AssetGenImage('assets/images/meeting_dark.png');

  /// File path: assets/images/spalsh_img.png
  AssetGenImage get spalshImg =>
      const AssetGenImage('assets/images/spalsh_img.png');

  /// File path: assets/images/splash_dark.png
  AssetGenImage get splashDark =>
      const AssetGenImage('assets/images/splash_dark.png');

  /// File path: assets/images/sport_dark.png
  AssetGenImage get sportDark =>
      const AssetGenImage('assets/images/sport_dark.png');

  /// File path: assets/images/sports.png
  AssetGenImage get sports => const AssetGenImage('assets/images/sports.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    logo,
    birthday,
    birthdayDark,
    bookClub,
    bookClubDark,
    eventlyDark,
    exhibition,
    exhibitionDark,
    gamming,
    logoDark,
    logoImg,
    meeting,
    meetingDark,
    spalshImg,
    splashDark,
    sportDark,
    sports,
  ];
}

abstract final class Assets {
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
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
