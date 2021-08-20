import 'package:dartz/dartz.dart';
import 'package:empresas_app/core/errors/failure.dart';
import 'package:empresas_app/features/domain/entities/investor_entity.dart';
import 'package:empresas_app/features/domain/entities/portfolio_entity.dart';
import 'package:empresas_app/features/domain/repositories/auth_repository.dart';
import 'package:empresas_app/features/domain/usecases/login_with_email_and_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

main() {
  late LoginWithEmailAndPassword _loginWithEmailAndPassword;
  late AuthRepository authRepository;

  setUp(() {
    authRepository = AuthRepositoryMock();
    _loginWithEmailAndPassword = LoginWithEmailAndPassword(authRepository);
  });

  final String email = 'any_email@mail.com.';
  final String password = '12341234';

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

  test('Should successfully sign in', () async {
    when(() => authRepository.doLogin(any(), any())).thenAnswer(
      (_) async => Right(investor),
    );
    final result = await _loginWithEmailAndPassword(
      LoginParams(email: email, password: password),
    );
    expect(result, Right(investor));
    verify(() => authRepository.doLogin(email, password));
    verifyNoMoreInteractions(() => authRepository);
  });

  test('Should return a SignInFailure on unsuccessful sign in', () async {
    when(() => authRepository.doLogin(any(), any())).thenAnswer(
      (_) async => Left(InvalidCredentialsFailure()),
    );
    final result = await _loginWithEmailAndPassword(
      LoginParams(email: email, password: password),
    );
    expect(result, Left(InvalidCredentialsFailure()));
    verify(() => authRepository.doLogin(email, password));
    verifyNoMoreInteractions(() => authRepository);
  });
}
