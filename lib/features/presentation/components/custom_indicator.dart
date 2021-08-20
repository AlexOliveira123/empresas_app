import 'dart:math' as math;

import '../../../core/theme/app_images.dart';
import 'package:flutter/material.dart';

void showLoading(BuildContext context, {barrierColor = Colors.black54}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: barrierColor,
    builder: (context) {
      return Center(child: CustomIndicator());
    },
  );
}

void hideLoading(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}

class CustomIndicator extends StatefulWidget {
  const CustomIndicator({Key? key}) : super(key: key);

  @override
  _CustomIndicatorState createState() => _CustomIndicatorState();
}

class _CustomIndicatorState extends State<CustomIndicator>
    with TickerProviderStateMixin {
  late AnimationController _firstAnimationController;
  late Animation<double> _firstAnimation;
  late AnimationController _secondAnimationController;
  late Animation<double> _secondAnimation;

  @override
  void initState() {
    _firstAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addListener(() => setState(() {}));
    _secondAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addListener(() => setState(() {}));
    _firstAnimation = Tween<double>(
      begin: -math.pi,
      end: math.pi,
    ).animate(_firstAnimationController);
    _secondAnimation = Tween<double>(
      begin: math.pi,
      end: -math.pi,
    ).animate(_secondAnimationController);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _firstAnimationController.repeat();
    _secondAnimationController.repeat();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _firstAnimationController.dispose();
    _secondAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Transform.rotate(
          angle: _firstAnimation.value,
          child: Image.asset(AppImages.firstIndicator),
        ),
        Transform.rotate(
          angle: _secondAnimation.value,
          child: Image.asset(AppImages.secondIndicator),
        ),
      ],
    );
  }
}
