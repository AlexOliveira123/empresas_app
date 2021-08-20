import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import '../entities/enterprise_entity.dart';
import '../repositories/enterprises_repository.dart';

@lazySingleton
class FetchEnterprises implements Usecase<List<EnterpriseEntity>, NoParams> {
  final EnterprisesRepository repository;

  FetchEnterprises(this.repository);

  Future<Either<Failure, List<EnterpriseEntity>>> call(
    NoParams noParams,
  ) async {
    return await repository.fetchEnterprises();
  }
}
