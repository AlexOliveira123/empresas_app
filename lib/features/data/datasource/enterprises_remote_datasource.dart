import 'package:injectable/injectable.dart';

import '../../../core/errors/exceptions.dart';
import '../../infra/http/rest_client.dart';
import '../models/enterprise_model.dart';
import 'enterprises_datasource.dart';

@Singleton(as: EnterprisesDatasource)
class EnterprisesRemoteDatasource implements EnterprisesDatasource {
  final RestClient _restClient;

  EnterprisesRemoteDatasource({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<List<EnterpriseModel>> fetchEnterprises() async {
    final response = await _restClient.get('/enterprises');
    if (response.statusCode == 200) {
      return (response.data['enterprises'] as List)
          .map((item) => EnterpriseModel.fromJson(item))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<EnterpriseModel>> findEnterprisesByText(String query) async {
    final response =
        await _restClient.get('/enterprises', queryParameters: {"name": query});
    if (response.statusCode == 200) {
      return (response.data['enterprises'] as List)
          .map((item) => EnterpriseModel.fromJson(item))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
