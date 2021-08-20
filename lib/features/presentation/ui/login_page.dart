import 'package:empresas_app/features/presentation/presenters/login_presenter_interface.dart';

import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../core/config/service_locator_config.dart';
import '../../../core/validators/validators.dart';
import '../components/custom_button.dart';
import '../components/custom_indicator.dart';
import '../components/custom_text_field.dart';
import '../components/dialog_component.dart';
import '../components/login_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = getIt.get<ILoginPresenter>();

  late ScrollController _scrollController;
  late List<ReactionDisposer> _disposers;

  bool _isScrolledToEnd = false;

  Future<void> _moveScroll({double? offset}) async {
    _scrollController.animateTo(
      140,
      duration: Duration(milliseconds: 500),
      curve: offset == null ? Curves.easeIn : Curves.easeOut,
    );
  }

  Future<void> _doLogin() async {
    if (!Validators.isValidEmail(_controller.email) ||
        !Validators.isValidPassword(_controller.password)) {
      return DialogComponent(
        title: 'Atenção!',
        description: 'Preencha os dados corretamente.',
        buttonText: 'OK',
      ).show(context);
    }
    showLoading(context);
    final result = await _controller.doLogin();
    if (result) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => HomePage()),
        (route) => false,
      );
    }
    hideLoading(context);
  }

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >= 240) {
          _isScrolledToEnd = true;
        } else {
          _isScrolledToEnd = false;
        }
        setState(() {});
      });
    _disposers = [];
    _disposers.addAll({
      reaction(
        (r) => _controller.email,
        (String email) {
          if (_controller.errorText != null) {
            _controller.setErrorText(null);
          }
        },
      ),
      reaction(
        (r) => _controller.password,
        (String password) {
          if (_controller.errorText != null) {
            _controller.setErrorText(null);
          }
        },
      ),
    });
    super.initState();
  }

  @override
  void dispose() {
    for (var i = 0; i < _disposers.length; i++) {
      _disposers[i].call();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            LoginHeader(),
          ];
        },
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            if (_isScrolledToEnd)
              SliverToBoxAdapter(
                child: SizedBox(height: 160),
              ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Observer(builder: (context) {
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 24),
                      CustomTextField(
                        label: 'E-mail',
                        keyboardType: TextInputType.emailAddress,
                        maxLength: 70,
                        onFocus: _moveScroll,
                        errorText: _controller.errorText,
                        onChanged: _controller.setEmail,
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        label: 'Senha',
                        maxLength: 20,
                        isPassword: true,
                        onFocus: _moveScroll,
                        errorText: _controller.errorText,
                        onChanged: _controller.setPassword,
                      ),
                      SizedBox(height: 24),
                      CustomButton(
                        text: 'ENTRAR',
                        isToShowLoader: false,
                        onTap: _doLogin,
                      )
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
