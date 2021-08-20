import 'package:dartz/dartz.dart';
import 'package:empresas_app/features/domain/entities/enterprise_entity.dart';
import 'package:empresas_app/features/domain/repositories/enterprises_repository.dart';
import 'package:empresas_app/features/domain/usecases/find_enterprises_by_text.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class EnterprisesRepositoryMock extends Mock implements EnterprisesRepository {}

main() {
  late FindEnterprisesByText _findEnterprisesByText;
  late EnterprisesRepository enterprisesRepository;

  setUp(() {
    enterprisesRepository = EnterprisesRepositoryMock();
    _findEnterprisesByText = FindEnterprisesByText(enterprisesRepository);
  });

  final String query = 'Superstore';
  final enterprise = <EnterpriseEntity>[
    EnterpriseEntity(
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

  test('Should get a enterprised founded', () async {
    when(() => enterprisesRepository.findEnterprisesByText(any())).thenAnswer(
      (_) async => Right(enterprise),
    );
    final result = await _findEnterprisesByText(SearchParams(query: query));
    expect(result, Right(enterprise));
    verify(() => enterprisesRepository.findEnterprisesByText(query));
    verifyNoMoreInteractions(enterprisesRepository);
  });
}
