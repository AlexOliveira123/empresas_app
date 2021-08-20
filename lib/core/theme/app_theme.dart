import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme(this.context);
  final BuildContext context;

  ThemeData get theme {
    return ThemeData(
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Rubik',
      appBarTheme: AppBarTheme(
        elevation: 0,
        brightness: Brightness.light,
        color: Colors.transparent,
      ),
      colorScheme: const ColorScheme.light().copyWith(
        primary: AppColors.primaryColor,
        brightness: Brightness.light,
        secondary: AppColors.primaryColor,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: AppColors.primaryColor.withOpacity(0.5),
        cursorColor: AppColors.primaryColor,
        selectionHandleColor: AppColors.primaryColor,
      ),
      cardColor: Colors.white,
      dialogBackgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(16),
        fillColor: AppColors.gray2Color,
        filled: true,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: AppColors.gray2Color,
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: AppColors.gray2Color,
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
      ),
      brightness: Brightness.light,
    );
  }
}
