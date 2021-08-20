import '../models/enterprise_model.dart';

abstract class EnterprisesDatasource {
  Future<List<EnterpriseModel>> findEnterprisesByText(String query);
  Future<List<EnterpriseModel>> fetchEnterprises();
}
