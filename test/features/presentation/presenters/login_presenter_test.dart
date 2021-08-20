import 'package:dartz/dartz.dart';
import 'package:empresas_app/core/errors/failure.dart';
import 'package:empresas_app/features/domain/entities/investor_entity.dart';
import 'package:empresas_app/features/domain/entities/portfolio_entity.dart';
import 'package:empresas_app/features/domain/usecases/login_with_email_and_password.dart';
import 'package:empresas_app/features/presentation/presenters/login_presenter.dart';
import 'package:empresas_app/features/presentation/presenters/login_presenter_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LoginWithEmailAndPasswordMock extends Mock
    implements LoginWithEmailAndPassword {}

void main() {
  late ILoginPresenter presenter;
  late LoginWithEmailAndPassword loginWithEmailAndPassword;

  final investor = InvestorEntity(
    id: 1,
    name: 'bob',
    email: 'bob@bob.com',
    city: 'bobland',
    country: 'bobstan',
    balance: 100.0,
    portfolioValue: 0,
    firstAccess: false,
    superAngel: false,
    portfolio: PortfolioEntity(
      enterprises: [],
      enterprisesNumber: 0,
    ),
  );
  setUp(() {
    loginWithEmailAndPassword = LoginWithEmailAndPasswordMock();
    presenter = LoginPresenter(loginWithEmailAndPassword);
  });

  test('Should set the email', () {
    expect(presenter.email, '');
    presenter.setEmail('any_mail');
    expect(presenter.email, equals('any_mail'));
  });

  test('Should set the password', () {
    expect(presenter.password, '');
    presenter.setPassword('any_password');
    expect(presenter.password, equals('any_password'));
  });

  test('Should set an error text', () {
    expect(presenter.errorText, null);
    presenter.setErrorText('any_error');
    expect(presenter.errorText, equals('any_error'));
  });
  test('Should do login after enter with valid credentials', () async {
    when(
      () => loginWithEmailAndPassword.call(
        LoginParams(email: 'any_mail@mail.com', password: 'any_password'),
      ),
    ).thenAnswer(
      (_) async => Right(investor),
    );
    presenter.setEmail('any_mail@mail.com');
    presenter.setPassword('any_password');
    final result = await presenter.doLogin();
    expect(result, isTrue);
    verify(
      () => loginWithEmailAndPassword.call(
        LoginParams(email: 'any_mail@mail.com', password: 'any_password'),
      ),
    ).called(1);
  });

  test('Should return a error message after enter with invalid credentials',
      () async {
    when(
      () => loginWithEmailAndPassword.call(
        LoginParams(email: 'any_mail@mail.com', password: 'any_password'),
      ),
    ).thenAnswer(
      (_) async =>
          Left(InvalidCredentialsFailure(message: 'Invalid credentials')),
    );
    presenter.setEmail('any_mail@mail.com');
    presenter.setPassword('any_password');
    final result = await presenter.doLogin();
    expect(result, isFalse);
    expect(presenter.errorText, equals('Credenciais inválidas'));
    verify(
      () => loginWithEmailAndPassword.call(
        LoginParams(email: 'any_mail@mail.com', password: 'any_password'),
      ),
    ).called(1);
  });
}
