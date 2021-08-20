import 'package:flutter/material.dart';

import '../../../core/theme/app_images.dart';

class IoasysLogo extends StatelessWidget {
  const IoasysLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.logoSymbol,
          width: 40,
          height: 32,
        ),
      ],
    );
  }
}
