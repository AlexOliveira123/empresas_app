import 'package:dartz/dartz.dart';
import 'package:empresas_app/core/errors/exceptions.dart';
import 'package:empresas_app/core/errors/failure.dart';
import 'package:empresas_app/features/data/datasource/enterprises_datasource.dart';
import 'package:empresas_app/features/data/models/enterprise_model.dart';
import 'package:empresas_app/features/data/repositories/enterprises_repository_impl.dart';
import 'package:empresas_app/features/domain/repositories/enterprises_repository.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class EnterprisesDatasourceMock extends Mock implements EnterprisesDatasource {}

main() {
  late EnterprisesRepository repository;
  late EnterprisesDatasource enterprisesDatasourceMock;

  String tQuery = 'Superstore';
  List<EnterpriseModel> enterpriseList = <EnterpriseModel>[
    EnterpriseModel(
      id: 1,
      ownEnterprise: false,
      name: 'Superstore',
      description: 'Description test',
      city: 'Bristol',
      country: 'UK',
      value: 100,
      sharePrice: 100.0,
      enterpriseTypeId: 1,
      enterpriseTypeName: 'Commerce',
    ),
  ];

  setUp(() {
    enterprisesDatasourceMock = EnterprisesDatasourceMock();
    repository = EnterprisesRepositoryImpl(
      datasource: enterprisesDatasourceMock,
    );
  });

  test('Should return a list of searched enterprises', () async {
    when(() => enterprisesDatasourceMock.findEnterprisesByText(any()))
        .thenAnswer((_) async => enterpriseList);
    final result = await repository.findEnterprisesByText(tQuery);
    verify(() => enterprisesDatasourceMock.findEnterprisesByText(tQuery));
    expect(result, Right(enterpriseList));
  });

  test('Should return a list of all enterprises', () async {
    when(() => enterprisesDatasourceMock.fetchEnterprises())
        .thenAnswer((_) async => enterpriseList);
    final result = await repository.fetchEnterprises();
    verify(() => enterprisesDatasourceMock.fetchEnterprises());
    expect(result, Right(enterpriseList));
  });

  test('Should throws ServerFailure on find enterprises by param', () async {
    when(() => enterprisesDatasourceMock.findEnterprisesByText(any()))
        .thenThrow(ServerException());
    final result = await repository.findEnterprisesByText(tQuery);
    verify(() => enterprisesDatasourceMock.findEnterprisesByText(tQuery));
    expect(result, Left(ServerFailure(message: 'Internal Server Error')));
  });

  test('Should throws ServerFailure on fetch enterprises', () async {
    when(() => enterprisesDatasourceMock.fetchEnterprises())
        .thenThrow(ServerException());
    final result = await repository.fetchEnterprises();
    verify(() => enterprisesDatasourceMock.fetchEnterprises());
    expect(result, Left(ServerFailure(message: 'Internal Server Error')));
  });
}
