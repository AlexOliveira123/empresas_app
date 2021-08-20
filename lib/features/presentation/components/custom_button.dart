import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.onTap,
    this.color,
    this.leading,
    this.tralling,
    this.isToShowLoader = true,
  }) : super(key: key);

  final String text;
  final Function? onTap;
  final Color? color;
  final Widget? leading;
  final Widget? tralling;
  final bool isToShowLoader;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: widget.color != null ? widget.color : AppColors.grayColor,
          borderRadius: BorderRadius.circular(12),
        ),
        height: 48.0,
        width: MediaQuery.of(context).size.width,
        duration: Duration(milliseconds: 300),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return AppColors.grayColor;
                }
                return AppColors.primaryColor; // Use the component's default.
              },
            ),
            elevation: MaterialStateProperty.all(0),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          key: Key('CustomButton'),
          onPressed: widget.onTap != null && !_isLoading
              ? widget.onTap != null
                  ? () async {
                      if (widget.isToShowLoader) {
                        try {
                          setState(() {
                            _isLoading = true;
                          });
                          await widget.onTap!();
                          setState(() {
                            _isLoading = false;
                          });
                        } on Exception {
                          setState(() {
                            _isLoading = false;
                          });
                          rethrow;
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      } else {
                        await widget.onTap!();
                      }
                    }
                  : null
              : null,
          child: Container(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AnimatedOpacity(
                  duration: Duration(milliseconds: 350),
                  opacity: _isLoading ? 0 : 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.leading ?? SizedBox(height: 0, width: 0),
                        SizedBox(width: widget.leading != null ? 8 : 0),
                        Text(
                          widget.text,
                          textAlign: TextAlign.center,
                          style: body1.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        SizedBox(width: widget.tralling != null ? 8 : 0),
                        widget.tralling ?? SizedBox(height: 0, width: 0),
                      ],
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 350),
                  opacity: _isLoading ? 1 : 0,
                  child: SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
