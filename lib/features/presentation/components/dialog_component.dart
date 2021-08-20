import '../../../core/theme/app_colors.dart';
import 'custom_button.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_typography.dart';

class DialogComponent extends StatefulWidget {
  const DialogComponent({
    required this.title,
    this.description = '',
    this.buttonText,
    this.onTap,
    this.barrierDismissible = true,
  });

  final String title;
  final String description;
  final VoidCallback? onTap;
  final String? buttonText;
  final bool barrierDismissible;

  @override
  _DialogComponentState createState() => _DialogComponentState();

  Future<dynamic> show(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => this,
      barrierDismissible: barrierDismissible,
    );
  }
}

class _DialogComponentState extends State<DialogComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: Key('KEY-DIALOG'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(
                fontSize: h6.fontSize,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (widget.description.isNotEmpty)
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: body1.fontSize,
                  color: AppColors.grayColor,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
            if (widget.description.isNotEmpty) SizedBox(height: 24),
            CustomButton(
              key: Key("KEY-DIALOGCOMPONENT-BUTTON"),
              text: widget.buttonText ?? '',
              onTap: widget.onTap == null
                  ? () => Navigator.of(context).pop()
                  : () {
                      widget.onTap!();
                    },
            ),
          ],
        ),
      ),
    );
  }
}
