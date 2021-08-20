import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';

import '../entities/investor_entity.dart';
import '../repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginWithEmailAndPassword
    implements Usecase<InvestorEntity, LoginParams> {
  final AuthRepository repository;

  LoginWithEmailAndPassword(this.repository);

  Future<Either<Failure, InvestorEntity>> call(
    LoginParams loginParams,
  ) async {
    return await repository.doLogin(loginParams.email, loginParams.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [this.email, this.password];
}
