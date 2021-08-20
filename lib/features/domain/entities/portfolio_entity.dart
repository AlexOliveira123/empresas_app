import 'package:equatable/equatable.dart';

import 'enterprise_entity.dart';

class PortfolioEntity extends Equatable {
  final int enterprisesNumber;
  final List<EnterpriseEntity> enterprises;

  PortfolioEntity({
    required this.enterprisesNumber,
    required this.enterprises,
  });

  @override
  List<Object?> get props {
    return <Object?>[
      enterprisesNumber,
      enterprises,
    ];
  }
}
