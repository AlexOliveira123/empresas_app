import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../core/usecase/usecase.dart';
import '../../domain/entities/enterprise_entity.dart';
import '../../domain/usecases/fetch_enterprises.dart';
import '../../domain/usecases/find_enterprises_by_text.dart';
import 'home_presenter_interface.dart';

part 'home_presenter.g.dart';

@LazySingleton(as: IHomePresenter)
class HomePresenter = _HomePresenterBase
    with _$HomePresenter
    implements IHomePresenter;

abstract class _HomePresenterBase with Store {
  final FindEnterprisesByText _findEnterprisesByText;
  final FetchEnterprises _fetchEnterprises;

  _HomePresenterBase(this._findEnterprisesByText, this._fetchEnterprises);

  @observable
  List<EnterpriseEntity> enterprisesList = <EnterpriseEntity>[];

  @observable
  bool isLoading = false;

  @observable
  bool hasError = false;

  @action
  Future<void> filterEnterprises(String query) async {
    isLoading = true;
    final result = await _findEnterprisesByText(SearchParams(query: query));
    result.fold((l) {
      hasError = true;
      return enterprisesList = [];
    }, (r) => enterprisesList = r);
    isLoading = false;
  }

  @action
  Future<void> getEnterprises() async {
    isLoading = true;
    final result = await _fetchEnterprises(NoParams());
    result.fold((l) {
      hasError = true;
      return enterprisesList = [];
    }, (r) => enterprisesList = r);
    isLoading = false;
  }
}
