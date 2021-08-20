import 'package:empresas_app/features/presentation/presenters/login_presenter_interface.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecases/login_with_email_and_password.dart';

part 'login_presenter.g.dart';

@Injectable(as: ILoginPresenter)
class LoginPresenter = _LoginPresenterBase
    with _$LoginPresenter
    implements ILoginPresenter;

abstract class _LoginPresenterBase with Store {
  final LoginWithEmailAndPassword _loginWithEmailAndPassword;

  _LoginPresenterBase(this._loginWithEmailAndPassword);

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String? errorText;

  @action
  void setErrorText(String? value) {
    errorText = value;
  }

  @action
  void setEmail(String value) {
    email = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  Future<bool> doLogin() async {
    final response = await _loginWithEmailAndPassword(
      LoginParams(email: email, password: password),
    );
    if (response.isLeft()) {
      setErrorText('Credenciais inválidas');
      return false;
    } else {
      return true;
    }
  }
}
