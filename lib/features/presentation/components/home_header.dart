import 'package:easy_debounce/easy_debounce.dart';
import 'package:empresas_app/core/theme/app_colors.dart';
import 'package:empresas_app/features/presentation/presenters/home_presenter_interface.dart';
import 'package:flutter/material.dart';

import '../../../core/config/service_locator_config.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_images.dart';
import 'background_component.dart';
import 'custom_text_field.dart';

class HomeHeader extends StatefulWidget {
  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final _controller = getIt.get<IHomePresenter>();

  @override
  void dispose() {
    EasyDebounce.cancel('filter-debounce');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.whiteColor,
      pinned: true,
      centerTitle: true,
      expandedHeight: 160,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 28),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomTextField(
            prefixIcon: AppIcons.searchIcon.icon(),
            hint: 'Pequise por uma empresa',
            onChanged: (value) {
              EasyDebounce.debounce(
                'filter-debounce',
                Duration(milliseconds: 500),
                () {
                  _controller.filterEnterprises(value);
                },
              );
            },
          ),
        ),
      ),
      flexibleSpace: Stack(
        children: [
          BackgroundComponent(height: 172),
          Image.asset(AppImages.illustration, fit: BoxFit.cover),
        ],
      ),
    );
  }
}
