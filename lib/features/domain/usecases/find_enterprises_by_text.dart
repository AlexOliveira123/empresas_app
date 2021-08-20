import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';

import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../entities/enterprise_entity.dart';
import '../repositories/enterprises_repository.dart';

@lazySingleton
class FindEnterprisesByText
    implements Usecase<List<EnterpriseEntity>, SearchParams> {
  final EnterprisesRepository repository;

  FindEnterprisesByText(this.repository);

  Future<Either<Failure, List<EnterpriseEntity>>> call(
    SearchParams searchParams,
  ) async {
    return await repository.findEnterprisesByText(searchParams.query);
  }
}

class SearchParams extends Equatable {
  final String query;

  SearchParams({required this.query});

  @override
  List<Object?> get props => <Object>[query];
}
