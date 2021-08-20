import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../entities/enterprise_entity.dart';

abstract class EnterprisesRepository {
  Future<Either<Failure, List<EnterpriseEntity>>> findEnterprisesByText(
    String query,
  );
  Future<Either<Failure, List<EnterpriseEntity>>> fetchEnterprises();
}
