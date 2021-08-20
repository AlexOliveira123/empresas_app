import '../../domain/entities/investor_entity.dart';
import 'portfolio_model.dart';

class InvestorModel extends InvestorEntity {
  InvestorModel({
    required id,
    required name,
    required email,
    required city,
    required country,
    required balance,
    required portfolio,
    photo,
    required portfolioValue,
    required firstAccess,
    required superAngel,
  }) : super(
          id: id,
          name: name,
          email: email,
          city: city,
          country: country,
          balance: balance,
          photo: photo,
          portfolio: portfolio,
          portfolioValue: portfolioValue,
          firstAccess: firstAccess,
          superAngel: superAngel,
        );

  factory InvestorModel.fromJson(Map<String, dynamic> json) {
    return InvestorModel(
      id: json['id'],
      name: json['investor_name'],
      email: json['email'],
      city: json['city'],
      country: json['country'],
      balance: json['balance'],
      portfolio: json['portfolio'] != null
          ? PortfolioModel.fromJson(json['portfolio'])
          : [],
      photo: json['photo'],
      portfolioValue: json['portfolio_value'],
      firstAccess: json['first_access'],
      superAngel: json['super_angel'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'investor_name': name,
      'email': email,
      'city': city,
      'country': country,
      'balance': balance,
      'photo': photo,
      'portfolio': (portfolio as PortfolioModel).toJson(),
      'portfolio_value': portfolioValue,
      'first_access': firstAccess,
      'super_angel': superAngel,
    };
  }
}
