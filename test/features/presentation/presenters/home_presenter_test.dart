import 'package:dartz/dartz.dart';
import 'package:empresas_app/core/errors/failure.dart';
import 'package:empresas_app/core/usecase/usecase.dart';
import 'package:empresas_app/features/domain/entities/enterprise_entity.dart';
import 'package:empresas_app/features/domain/usecases/fetch_enterprises.dart';
import 'package:empresas_app/features/domain/usecases/find_enterprises_by_text.dart';
import 'package:empresas_app/features/presentation/presenters/home_presenter.dart';
import 'package:empresas_app/features/presentation/presenters/home_presenter_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FetchEnterprisesMock extends Mock implements FetchEnterprises {}

class FindEnterprisesByTextMock extends Mock implements FindEnterprisesByText {}

void main() {
  late IHomePresenter presenter;
  late FetchEnterprisesMock fetchEnterprises;
  late FindEnterprisesByText findEnterprisesByText;

  final enterprisesList = <EnterpriseEntity>[
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

  setUp(() {
    fetchEnterprises = FetchEnterprisesMock();
    findEnterprisesByText = FindEnterprisesByTextMock();
    presenter = HomePresenter(
      findEnterprisesByText,
      fetchEnterprises,
    );
  });
  test('Should get the enterprises', () async {
    when(() => fetchEnterprises.call(NoParams())).thenAnswer(
      (_) async => Right(enterprisesList),
    );
    await presenter.getEnterprises();
    expect(presenter.enterprisesList, equals(enterprisesList));
    verify(() => fetchEnterprises.call(NoParams())).called(1);
  });

  test('Should occurs an error on get the enterprises', () async {
    when(() => fetchEnterprises.call(NoParams())).thenAnswer(
      (_) async => Left(ServerFailure(message: 'Internal server error')),
    );
    expect(presenter.hasError, isFalse);
    await presenter.getEnterprises();
    expect(presenter.hasError, isTrue);
    verify(() => fetchEnterprises.call(NoParams())).called(1);
  });

  test('Should find the enterprises by text', () async {
    when(() => findEnterprisesByText.call(SearchParams(query: 'a'))).thenAnswer(
      (_) async => Right(enterprisesList),
    );
    await presenter.filterEnterprises('a');
    expect(presenter.enterprisesList, equals(enterprisesList));
    verify(() => findEnterprisesByText.call(SearchParams(query: 'a')))
        .called(1);
  });

  test('Should occurs an error on find the enterprises by text', () async {
    when(() => findEnterprisesByText.call(SearchParams(query: 'a'))).thenAnswer(
      (_) async => Left(ServerFailure(message: 'Internal server error')),
    );
    expect(presenter.hasError, isFalse);
    await presenter.filterEnterprises('a');
    expect(presenter.hasError, isTrue);
    verify(() => findEnterprisesByText.call(SearchParams(query: 'a')))
        .called(1);
  });
}
