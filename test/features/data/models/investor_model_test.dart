import 'dart:convert';

import 'package:empresas_app/features/data/models/investor_model.dart';
import 'package:empresas_app/features/data/models/portfolio_model.dart';
import 'package:empresas_app/features/domain/entities/enterprise_entity.dart';
import 'package:empresas_app/features/domain/entities/investor_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/json_reader.dart';

main() {
  final investor = InvestorModel(
    id: 1,
    name: 'Teste Apple',
    email: 'testeapple@ioasys.com.br',
    city: 'BH',
    country: 'Brasil',
    balance: 1000000.0,
    photo: null,
    portfolio: PortfolioModel(
      enterprisesNumber: 0,
      enterprises: <EnterpriseEntity>[],
    ),
    portfolioValue: 1000000.0,
    firstAccess: false,
    superAngel: false,
  );

  test('Should be a Investor Entity', () {
    expect(investor, isA<InvestorEntity>());
  });

  test('Should return a investor parsed', () {
    final decodedJson = json.decode(jsonReader('auth_success.json'));
    final investor = InvestorModel.fromJson(decodedJson['investor']);
    expect(investor, investor);
  });
}
