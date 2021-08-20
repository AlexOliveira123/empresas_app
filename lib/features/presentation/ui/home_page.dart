import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../core/config/service_locator_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../components/custom_indicator.dart';
import '../components/dialog_component.dart';
import '../components/enterprise_item.dart';
import '../components/home_header.dart';
import '../presenters/home_presenter_interface.dart';
import 'enterprise_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = getIt.get<IHomePresenter>();

  var disposer;

  @override
  void initState() {
    disposer = reaction(
      (r) => _controller.hasError,
      (bool hasError) {
        if (hasError) {
          DialogComponent(
            title: 'Atenção!',
            description: 'Ocorreu um erro. Contate o administrador!',
            buttonText: 'OK',
            barrierDismissible: false,
            onTap: () {
              _controller.hasError = false;
            },
          ).show(context);
        }
      },
    );
    _controller.getEnterprises();
    super.initState();
  }

  @override
  void dispose() {
    disposer?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                HomeHeader(),
              ];
            },
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height: 16),
                  ),
                  if (!_controller.isLoading &&
                      _controller.enterprisesList.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Text(
                        '${_controller.enterprisesList.length} resultados encontrados',
                        style: subtitle2.copyWith(
                          color: AppColors.grayColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 16),
                  ),
                  if (_controller.isLoading)
                    SliverFillRemaining(
                      child: CustomIndicator(),
                    ),
                  if (_controller.enterprisesList.isEmpty &&
                      !_controller.isLoading)
                    SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'Nenhum resultado encontrado',
                          style: body1.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  if (_controller.enterprisesList.isNotEmpty &&
                      !_controller.isLoading)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) {
                          final enterprise = _controller.enterprisesList[i];
                          return EnterpriseIntem(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) {
                                    return EnterpriseDetailsPage(
                                      enterprise: enterprise,
                                    );
                                  },
                                ),
                              );
                            },
                            enterprise: enterprise,
                          );
                        },
                        childCount: _controller.enterprisesList.length,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
