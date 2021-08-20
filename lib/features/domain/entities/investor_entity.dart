import 'package:equatable/equatable.dart';

import 'portfolio_entity.dart';

class InvestorEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String city;
  final String country;
  final double balance;
  final String? photo;
  final PortfolioEntity portfolio;
  final double portfolioValue;
  final bool firstAccess;
  final bool superAngel;

  InvestorEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
    required this.country,
    required this.balance,
    required this.portfolio,
    this.photo,
    required this.portfolioValue,
    required this.firstAccess,
    required this.superAngel,
  });

  @override
  List<Object?> get props {
    return <Object?>[
      id,
      name,
      email,
      city,
      country,
      balance,
      portfolio,
      photo,
      portfolioValue,
      firstAccess,
      superAngel,
    ];
  }
}
