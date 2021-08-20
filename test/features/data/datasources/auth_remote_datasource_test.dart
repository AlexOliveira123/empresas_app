import 'dart:convert';

import 'package:empresas_app/features/data/datasource/auth_remote_datasource.dart';
import 'package:empresas_app/features/infra/http/rest_client.dart';
import 'package:empresas_app/features/infra/http/rest_client_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/json_reader.dart';

class DioMock extends Mock implements RestClient {}

main() {
  late AuthRemoteDatasource authRemoteDatasource;
  late RestClient client;

  final email = 'any_mail@mail.com';
  final password = '12341234';

  setUp(() {
    client = DioMock();
    authRemoteDatasource = AuthRemoteDatasource(restClient: client);
  });

  final authSuccess = json.decode(jsonReader('auth_success.json'));

  test('Should do login after post method called with valid credentials',
      () async {
    when(() => client.post(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).thenAnswer(
      (_) async => RestClientResponse(
        data: authSuccess,
        statusCode: 200,
        statusMessage: 'any_message',
      ),
    );
    final result = await authRemoteDatasource.doLogin(email, password);
    expect(result.id, equals(1));
    verify(
      () => client.post(
        any(),
        data: any(named: 'data'),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).called(1);
  });
}
