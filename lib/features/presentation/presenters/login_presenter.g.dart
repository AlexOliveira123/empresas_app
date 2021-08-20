// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginPresenter on _LoginPresenterBase, Store {
  final _$emailAtom = Atom(name: '_LoginPresenterBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginPresenterBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$errorTextAtom = Atom(name: '_LoginPresenterBase.errorText');

  @override
  String? get errorText {
    _$errorTextAtom.reportRead();
    return super.errorText;
  }

  @override
  set errorText(String? value) {
    _$errorTextAtom.reportWrite(value, super.errorText, () {
      super.errorText = value;
    });
  }

  final _$doLoginAsyncAction = AsyncAction('_LoginPresenterBase.doLogin');

  @override
  Future<bool> doLogin() {
    return _$doLoginAsyncAction.run(() => super.doLogin());
  }

  final _$_LoginPresenterBaseActionController =
      ActionController(name: '_LoginPresenterBase');

  @override
  void setErrorText(String? value) {
    final _$actionInfo = _$_LoginPresenterBaseActionController.startAction(
        name: '_LoginPresenterBase.setErrorText');
    try {
      return super.setErrorText(value);
    } finally {
      _$_LoginPresenterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_LoginPresenterBaseActionController.startAction(
        name: '_LoginPresenterBase.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_LoginPresenterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_LoginPresenterBaseActionController.startAction(
        name: '_LoginPresenterBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginPresenterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
errorText: ${errorText}
    ''';
  }
}
