// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePresenter on _HomePresenterBase, Store {
  final _$enterprisesListAtom =
      Atom(name: '_HomePresenterBase.enterprisesList');

  @override
  List<EnterpriseEntity> get enterprisesList {
    _$enterprisesListAtom.reportRead();
    return super.enterprisesList;
  }

  @override
  set enterprisesList(List<EnterpriseEntity> value) {
    _$enterprisesListAtom.reportWrite(value, super.enterprisesList, () {
      super.enterprisesList = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_HomePresenterBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$hasErrorAtom = Atom(name: '_HomePresenterBase.hasError');

  @override
  bool get hasError {
    _$hasErrorAtom.reportRead();
    return super.hasError;
  }

  @override
  set hasError(bool value) {
    _$hasErrorAtom.reportWrite(value, super.hasError, () {
      super.hasError = value;
    });
  }

  final _$filterEnterprisesAsyncAction =
      AsyncAction('_HomePresenterBase.filterEnterprises');

  @override
  Future<void> filterEnterprises(String query) {
    return _$filterEnterprisesAsyncAction
        .run(() => super.filterEnterprises(query));
  }

  final _$getEnterprisesAsyncAction =
      AsyncAction('_HomePresenterBase.getEnterprises');

  @override
  Future<void> getEnterprises() {
    return _$getEnterprisesAsyncAction.run(() => super.getEnterprises());
  }

  @override
  String toString() {
    return '''
enterprisesList: ${enterprisesList},
isLoading: ${isLoading},
hasError: ${hasError}
    ''';
  }
}
