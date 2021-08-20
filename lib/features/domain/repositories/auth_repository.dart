import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';

import '../entities/investor_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, InvestorEntity>> doLogin(
    String email,
    String password,
  );
}
