import 'dart:ui';

import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.label = '',
    this.hint = '',
    this.isPassword = false,
    this.keyboardType,
    this.icon,
    this.onChanged,
    this.onFocus,
    this.onEditingComplete,
    this.onSubmitted,
    this.maxLength,
    this.enable = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.prefix,
    this.showNotEditable = false,
    this.autofocus = false,
    this.upperCase = false,
    this.inputFormatters = const [],
    this.searchMode = false,
    this.textCapitalization = TextCapitalization.none,
    this.mandatory = false,
    this.errorText,
    this.helpText,
    this.focusNode,
    this.text,
    this.onClear,
    this.initialValue,
    this.validator,
    this.controller,
  }) : super(key: key);
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? prefix;
  final void Function(String)? onChanged;
  final void Function()? onFocus;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final int? maxLength;
  final String? errorText;
  final String? helpText;
  final FocusNode? focusNode;
  final bool isPassword;
  final bool autofocus;
  final bool enable;
  final TextInputAction textInputAction;
  final bool readOnly;
  final int maxLines;
  final String? text;
  final bool showNotEditable;
  final bool upperCase;
  final Function? onClear;
  final String? initialValue;
  final Function(String)? validator;
  final TextEditingController? controller;
  final List<TextInputFormatter> inputFormatters;
  final bool searchMode;
  final TextCapitalization textCapitalization;
  final bool mandatory;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  late bool _obscureText;
  late FocusNode _focusNode;
  late bool _ok;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    _ok = true;
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
    }
    if (widget.controller == null) {
      _controller = TextEditingController();
    } else {
      _controller = widget.controller!;
    }

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        if (widget.onFocus != null) {
          widget.onFocus!();
        }
      }
    });

    _controller.addListener(() {
      if (_controller.selection.start < 0) {
        _controller.selection = TextSelection.fromPosition(
          TextPosition(
            offset: _controller.text.length,
          ),
        );
      }
    });
    _refreshFocus();
  }

  void _refreshFocus() {
    _focusNode.addListener(() {
      if (widget.mandatory &&
          _controller.text.isEmpty &&
          !_focusNode.hasFocus) {
        _ok = false;
      } else {
        _ok = true;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.focusNode == null) {
      _focusNode.removeListener(() {});
      _focusNode.dispose();
    }

    _controller.removeListener(() {});
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label.isNotEmpty)
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  widget.label,
                  style: body2.copyWith(
                    color: AppColors.grayColor,
                  ),
                ),
              ),
              if (!widget.enable && widget.showNotEditable)
                Text(
                  'Não editável',
                  style: h4.copyWith(color: AppColors.grayColor),
                ),
            ],
          ),
        if (widget.label.isNotEmpty) SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                strutStyle: StrutStyle(
                  fontSize: body1.fontSize,
                ),
                textCapitalization: widget.textCapitalization,
                autofocus: widget.autofocus,
                enabled: widget.enable,
                inputFormatters: widget.inputFormatters,
                key: Key('KEY-CUSTOM-TEXT-FIELD'),
                buildCounter: (
                  context, {
                  required currentLength,
                  maxLength,
                  required isFocused,
                }) {
                  return Container();
                },
                maxLines: widget.maxLines,
                readOnly: widget.readOnly,
                textInputAction: widget.textInputAction,
                style: body1.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
                onChanged: (text) {
                  if (widget.onChanged != null) {
                    widget.onChanged!(text);
                  }
                  setState(() {});
                },
                controller: _controller,
                keyboardType: widget.keyboardType,
                focusNode: _focusNode,
                onEditingComplete: () {
                  if (widget.onEditingComplete != null) {
                    widget.onEditingComplete!();
                  }
                  if (widget.mandatory && _controller.text.isEmpty) {
                    _ok = false;
                  } else {
                    _ok = true;
                  }
                  node.nextFocus();
                },
                cursorColor: AppColors.primaryColor,
                obscureText: _obscureText,
                maxLength: widget.maxLength,
                decoration: InputDecoration(
                  prefix: widget.prefix,
                  fillColor: AppColors.gray2Color,
                  focusColor: Colors.white,
                  filled: true,
                  errorText: widget.errorText,
                  errorStyle: TextStyle(fontSize: 0),
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.errorText != null
                      ? AppIcons.errorIcon.icon()
                      : widget.isPassword
                          ? InkWell(
                              key: Key('IconEyePassword'),
                              onTap: () {
                                setState(
                                  () {
                                    _obscureText = !_obscureText;
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(18),
                                child: Icon(
                                  _obscureText
                                      ? Icons.remove_red_eye
                                      : Icons.remove_red_eye_outlined,
                                  size: 20,
                                  color: AppColors.grayColor,
                                ),
                              ),
                            )
                          : null,
                  hintText: widget.hint,
                  hintStyle: subtitle1.copyWith(
                    fontSize: 20,
                    color: AppColors.grayColor,
                    fontWeight: FontWeight.w300,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: AppColors.gray2Color,
                      style: BorderStyle.solid,
                      width: 1.5,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: AppColors.errorColor,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: AppColors.errorColor,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: AppColors.gray2Color,
                      style: BorderStyle.solid,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            if (widget.searchMode && _controller.text.isNotEmpty)
              GestureDetector(
                key: Key('KEY-CLEAR-SEARCH'),
                onTap: () {
                  setState(() {});
                  _controller.clear();
                  widget.onClear!();
                },
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Text(
                      'Limpar',
                      style: h4.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        if ((widget.errorText?.isNotEmpty ?? false) || widget.mandatory && !_ok)
          Padding(
            padding: const EdgeInsets.only(right: 8, top: 4),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                widget.mandatory && !_ok
                    ? 'Campo obrigatório.'
                    : widget.errorText ?? '',
                style: caption.copyWith(
                  fontWeight: FontWeight.w300,
                  color: AppColors.errorColor,
                ),
              ),
            ),
          ),
        if (widget.helpText?.isNotEmpty == true)
          Padding(
            padding: const EdgeInsets.only(right: 8, top: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.helpText!,
                style: h4.copyWith(
                  color: AppColors.grayColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
      ],
    );
  }
}
