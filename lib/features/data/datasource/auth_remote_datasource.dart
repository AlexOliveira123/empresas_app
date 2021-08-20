import 'package:injectable/injectable.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failure.dart';
import '../../infra/http/rest_client.dart';
import '../models/investor_model.dart';
import 'auth_datasource.dart';

@Singleton(as: AuthDatasource)
class AuthRemoteDatasource implements AuthDatasource {
  final RestClient _restClient;

  AuthRemoteDatasource({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<InvestorModel> doLogin(String email, String password) async {
    try {
      final response = await _restClient.post(
        '/users/auth/sign_in',
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200 && response.data['success']) {
        return InvestorModel.fromJson(response.data['investor']);
      } else {
        throw InvalidCredentialsFailure(
          message: response.data['errors'].first,
        );
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
