import '../../domain/entities/portfolio_entity.dart';
import 'enterprise_model.dart';

class PortfolioModel extends PortfolioEntity {
  PortfolioModel({
    required enterprisesNumber,
    required enterprises,
  }) : super(
          enterprisesNumber: enterprisesNumber,
          enterprises: enterprises,
        );

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
      enterprisesNumber: json['enterprises_number'],
      enterprises: json['enterprises'] != null
          ? (json['enterprises'] as List)
              .map((item) => EnterpriseModel.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final enterprises = (this.enterprises as List<EnterpriseModel>)
        .map((e) => e.toJson())
        .toList();

    return <String, dynamic>{
      'enterprises_number': enterprisesNumber,
      'enterprises': enterprises
    };
  }
}
