import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../consts/assets_conts.dart';

enum AppIconType { svg, png }

class AppIcons {
  static const path = AssetsConsts.icons;
  static const errorIcon = '${path}error_icon.svg';
  static const searchIcon = '${path}search_icon.svg';
  static const leftIcon = '${path}left_icon.svg';
}

extension AppIconsExt on String {
  AppIcon icon({
    String? icon,
    Key? key,
    BoxFit? fit,
    Color? color,
    double? width,
    double? height,
    GestureTapCallback? onTap,
  }) {
    return AppIcon(
      icon: this,
      key: key,
      fit: fit,
      color: color,
      width: width,
      height: height,
      onTap: onTap,
    );
  }
}

class AppIcon extends StatelessWidget {
  const AppIcon({
    required this.icon,
    this.key,
    this.fit,
    this.color,
    this.width,
    this.height,
    this.onTap,
    this.appIconType = AppIconType.svg,
  }) : super(key: key);

  final Key? key;
  final String icon;
  final BoxFit? fit;
  final Color? color;
  final double? height;
  final double? width;
  final GestureTapCallback? onTap;
  final AppIconType? appIconType;

  AppIcon copyWith({Color? color}) {
    return AppIcon(
      appIconType: this.appIconType,
      color: color ?? this.color,
      fit: this.fit,
      height: this.height,
      icon: this.icon,
      key: this.key,
      onTap: this.onTap,
      width: this.width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: onTap,
        child: appIconType == AppIconType.svg
            ? SvgPicture.asset(
                icon,
                fit: fit ?? BoxFit.none,
                color: color,
                width: width,
                height: height,
              )
            : Image.asset(
                icon,
                filterQuality: FilterQuality.high,
              ),
      ),
    );
  }
}
