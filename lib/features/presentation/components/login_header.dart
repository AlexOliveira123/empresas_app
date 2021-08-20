import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'ioasys_logo.dart';

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      centerTitle: true,
      elevation: 0,
      toolbarHeight: 128,
      title: Center(child: IoasysLogo()),
      expandedHeight: 257,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(2000, 400),
        ),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(2000, 400),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: <Color>[
              Color(0xFFA980A7),
              Color(0xFFB23D80),
              Color(0xFFB52773),
              AppColors.primaryColor,
            ],
          ),
        ),
        child: FlexibleSpaceBar(
          background: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Text(
                  'Seja bem vindo ao empresas!',
                  style: h6.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.whiteColor,
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
