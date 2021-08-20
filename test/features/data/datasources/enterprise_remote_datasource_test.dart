import 'dart:convert';

import 'package:empresas_app/core/errors/exceptions.dart';
import 'package:empresas_app/features/data/datasource/enterprises_datasource.dart';
import 'package:empresas_app/features/data/datasource/enterprises_remote_datasource.dart';
import 'package:empresas_app/features/domain/entities/enterprise_entity.dart';
import 'package:empresas_app/features/infra/http/rest_client.dart';
import 'package:empresas_app/features/infra/http/rest_client_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/json_reader.dart';

class DioMock extends Mock implements RestClient {}

main() {
  late EnterprisesDatasource enterprisesDatasource;
  late RestClient client;

  setUp(() {
    client = DioMock();
    enterprisesDatasource = EnterprisesRemoteDatasource(restClient: client);
  });

  final fixture = json.decode(jsonReader('enterprises.json'));

  test('Should get enterprises list', () async {
    when(() => client.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).thenAnswer(
      (_) async => RestClientResponse(
        data: fixture,
        statusCode: 200,
        statusMessage: 'any_message',
      ),
    );
    final result = await enterprisesDatasource.fetchEnterprises();
    expect(result, isA<List<EnterpriseEntity>>());
    expect(result.length, equals(3));
    verify(
      () => client.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).called(1);
  });

  test('Should throw ServerException on fetch enterprises list', () async {
    when(() => client.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).thenThrow(ServerException);
    final result = enterprisesDatasource.fetchEnterprises();
    expect(result, throwsA(ServerException));
    verify(
      () => client.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).called(1);
  });

  test('Should find the enterprises by text', () async {
    when(() => client.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).thenAnswer(
      (_) async => RestClientResponse(
        data: fixture,
        statusCode: 200,
        statusMessage: 'any_message',
      ),
    );
    final result = await enterprisesDatasource.findEnterprisesByText('');
    expect(result, isA<List<EnterpriseEntity>>());
    expect(result.length, equals(3));
    verify(
      () => client.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).called(1);
  });

  test('Should throw ServerExpcetion on find the enterprises by text',
      () async {
    when(() => client.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).thenThrow(ServerException);
    final result = enterprisesDatasource.findEnterprisesByText('');
    expect(result, throwsA(ServerException));
    verify(
      () => client.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).called(1);
  });
}
