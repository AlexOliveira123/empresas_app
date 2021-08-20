import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failure.dart';
import '../../domain/entities/enterprise_entity.dart';
import '../../domain/repositories/enterprises_repository.dart';
import '../datasource/enterprises_datasource.dart';

@LazySingleton(as: EnterprisesRepository)
class EnterprisesRepositoryImpl implements EnterprisesRepository {
  final EnterprisesDatasource datasource;

  EnterprisesRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<EnterpriseEntity>>> fetchEnterprises() async {
    try {
      return Right(await datasource.fetchEnterprises());
    } on ServerException {
      return Left(ServerFailure(message: 'Internal Server Error'));
    }
  }

  @override
  Future<Either<Failure, List<EnterpriseEntity>>> findEnterprisesByText(
    String query,
  ) async {
    try {
      return Right(await datasource.findEnterprisesByText(query));
    } on ServerException {
      return Left(ServerFailure(message: 'Internal Server Error'));
    }
  }
}
