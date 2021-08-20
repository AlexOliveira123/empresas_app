import 'dart:convert';

import 'package:empresas_app/features/data/models/enterprise_model.dart';
import 'package:empresas_app/features/domain/entities/enterprise_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/json_reader.dart';

main() {
  final tEnterpriseModel = EnterpriseModel(
    id: 1,
    ownEnterprise: false,
    name: 'Superstore',
    description: 'Description test',
    city: 'Bristol',
    country: 'UK',
    value: 100,
    sharePrice: 100.0,
    enterpriseTypeId: 1,
    enterpriseTypeName: 'Commerce',
  );

  test('Should be a enterprise entity', () {
    expect(tEnterpriseModel, isA<EnterpriseEntity>());
  });

  test('Should return a list after from json factory called', () {
    final decodedJson = json.decode(jsonReader('enterprises.json'));
    final enterprisesList = (decodedJson['enterprises'] as List)
        .map((item) => EnterpriseModel.fromJson(item))
        .toList();
    expect(enterprisesList[0], isA<EnterpriseEntity>());
  });

  test('Should return a mapped json from EntrepriseModel', () {
    final Map<String, dynamic> result = tEnterpriseModel.toJson();
    final Map<String, dynamic> map = <String, dynamic>{
      'id': 1,
      'email_enterprise': null,
      'facebook': null,
      'twitter': null,
      'linkedin': null,
      'phone': null,
      'own_enterprise': false,
      'enterprise_name': 'Superstore',
      'photo': null,
      'description': 'Description test',
      'city': 'Bristol',
      'country': 'UK',
      'value': 100,
      'share_price': 100.0,
      'enterprise_type': {'id': 1, 'enterprise_type_name': 'Commerce'}
    };
    expect(result, map);
  });
}
