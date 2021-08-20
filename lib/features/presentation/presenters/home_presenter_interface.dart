import 'package:empresas_app/features/domain/entities/enterprise_entity.dart';

abstract class IHomePresenter {
  abstract List<EnterpriseEntity> enterprisesList;
  abstract bool isLoading;
  abstract bool hasError;
  Future<void> filterEnterprises(String query);
  Future<void> getEnterprises();
}
