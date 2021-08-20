import 'package:dartz/dartz.dart';
import 'package:empresas_app/core/errors/exceptions.dart';
import 'package:empresas_app/core/errors/failure.dart';
import 'package:empresas_app/features/data/datasource/auth_datasource.dart';
import 'package:empresas_app/features/data/models/enterprise_model.dart';
import 'package:empresas_app/features/data/models/investor_model.dart';
import 'package:empresas_app/features/data/models/portfolio_model.dart';
import 'package:empresas_app/features/data/repositories/auth_repository_impl.dart';
import 'package:empresas_app/features/domain/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AuthDatasourceMock extends Mock implements AuthDatasource {}

main() {
  late AuthRepository repository;
  late AuthDatasource authDatasource;

  final String email = 'testeapple@ioasys.com.br';
  final String password = '123';

  final investorModel = InvestorModel(
    id: 1,
    name: 'Teste Apple',
    email: 'testeapple@ioasys.com.br',
    city: 'BH',
    country: 'Brasil',
    balance: 1000000.0,
    photo: null,
    portfolioValue: 1000000.0,
    firstAccess: false,
    superAngel: false,
    portfolio: PortfolioModel(
      enterprises: <EnterpriseModel>[],
      enterprisesNumber: 0,
    ),
  );

  setUp(() {
    authDatasource = AuthDatasourceMock();
    repository = AuthRepositoryImpl(datasource: authDatasource);
  });

  test('Should return a Investor on Login success', () async {
    when(() => authDatasource.doLogin(any(), any())).thenAnswer(
      (_) async => investorModel,
    );
    final result = await repository.doLogin(email, password);
    verify(() => authDatasource.doLogin(email, password)).called(1);
    expect(result, Right(investorModel));
  });

  test('Should throw a ServerFailure on Login', () async {
    when(() => authDatasource.doLogin(any(), any())).thenThrow(
      ServerException(),
    );
    final result = await repository.doLogin(email, password);
    verify(() => authDatasource.doLogin(email, password)).called(1);
    expect(result, Left(ServerFailure(message: 'Internal server error')));
  });
}
