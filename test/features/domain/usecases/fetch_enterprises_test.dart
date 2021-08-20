import 'package:dartz/dartz.dart';
import 'package:empresas_app/core/usecase/usecase.dart';
import 'package:empresas_app/features/domain/entities/enterprise_entity.dart';
import 'package:empresas_app/features/domain/repositories/enterprises_repository.dart';
import 'package:empresas_app/features/domain/usecases/fetch_enterprises.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class EnterprisesRepositoryMock extends Mock implements EnterprisesRepository {}

main() {
  late FetchEnterprises _fetchEnterprises;
  late EnterprisesRepository enterprisesRepository;

  setUp(() {
    enterprisesRepository = EnterprisesRepositoryMock();
    _fetchEnterprises = FetchEnterprises(enterprisesRepository);
  });

  final List<EnterpriseEntity> enterprisesList = <EnterpriseEntity>[
    EnterpriseEntity(
      id: 1,
      ownEnterprise: false,
      name: 'Superstore',
      description: 'Description test',
      value: 100,
      sharePrice: 100.0,
      enterpriseTypeId: 1,
      enterpriseTypeName: 'Commerce',
    ),
    EnterpriseEntity(
      id: 2,
      ownEnterprise: false,
      name: 'Bob\'s Restaurant',
      description: 'Description test',
      value: 10,
      sharePrice: 105.0,
      enterpriseTypeId: 2,
      enterpriseTypeName: 'food',
    ),
  ];

  test('Should get a list of all enterprises', () async {
    when(() => enterprisesRepository.fetchEnterprises()).thenAnswer(
      (_) async => Right(enterprisesList),
    );

    final result = await _fetchEnterprises(NoParams());

    expect(result, Right(enterprisesList));
    verify(() => enterprisesRepository.fetchEnterprises());
    verifyNoMoreInteractions(enterprisesRepository);
  });
}
