import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failure.dart';
import '../../domain/entities/investor_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, InvestorEntity>> doLogin(
      String email, String password) async {
    try {
      return Right(await datasource.doLogin(email, password));
    } on ServerException {
      return Left(ServerFailure(message: 'Internal server error'));
    } on InvalidCredentialsFailure catch (e) {
      return Left(InvalidCredentialsFailure(message: e.message));
    }
  }
}
