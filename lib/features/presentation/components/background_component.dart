import 'package:flutter/material.dart';

import '../../../core/theme/app_images.dart';

class BackgroundComponent extends StatelessWidget {
  final double? width;
  final double? height;
  const BackgroundComponent({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.background,
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height,
      fit: BoxFit.fill,
    );
  }
}
