// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i16;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/data/datasource/auth_datasource.dart' as _i5;
import '../../features/data/datasource/auth_remote_datasource.dart' as _i20;
import '../../features/data/datasource/enterprises_datasource.dart' as _i8;
import '../../features/data/datasource/enterprises_remote_datasource.dart'
    as _i21;
import '../../features/data/repositories/auth_repository_impl.dart' as _i4;
import '../../features/data/repositories/enterprises_repository_impl.dart'
    as _i7;
import '../../features/domain/repositories/auth_repository.dart' as _i3;
import '../../features/domain/repositories/enterprises_repository.dart' as _i6;
import '../../features/domain/usecases/fetch_enterprises.dart' as _i9;
import '../../features/domain/usecases/find_enterprises_by_text.dart' as _i10;
import '../../features/domain/usecases/login_with_email_and_password.dart'
    as _i13;
import '../../features/infra/cache/local_storage_adapter.dart' as _i17;
import '../../features/infra/cache/protocols/secure_cache_storage.dart' as _i22;
import '../../features/infra/http/dio_adapter.dart' as _i19;
import '../../features/infra/http/rest_client.dart' as _i18;
import '../../features/presentation/presenters/home_presenter.dart' as _i12;
import '../../features/presentation/presenters/home_presenter_interface.dart'
    as _i11;
import '../../features/presentation/presenters/login_presenter.dart' as _i15;
import '../../features/presentation/presenters/login_presenter_interface.dart'
    as _i14; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final secureCacheStorage = _$SecureCacheStorage();
  gh.lazySingleton<_i3.AuthRepository>(
      () => _i4.AuthRepositoryImpl(datasource: get<_i5.AuthDatasource>()));
  gh.lazySingleton<_i6.EnterprisesRepository>(() =>
      _i7.EnterprisesRepositoryImpl(
          datasource: get<_i8.EnterprisesDatasource>()));
  gh.lazySingleton<_i9.FetchEnterprises>(
      () => _i9.FetchEnterprises(get<_i6.EnterprisesRepository>()));
  gh.lazySingleton<_i10.FindEnterprisesByText>(
      () => _i10.FindEnterprisesByText(get<_i6.EnterprisesRepository>()));
  gh.lazySingleton<_i11.IHomePresenter>(() => _i12.HomePresenter(
      get<_i10.FindEnterprisesByText>(), get<_i9.FetchEnterprises>()));
  gh.lazySingleton<_i13.LoginWithEmailAndPassword>(
      () => _i13.LoginWithEmailAndPassword(get<_i3.AuthRepository>()));
  gh.factory<_i14.ILoginPresenter>(
      () => _i15.LoginPresenter(get<_i13.LoginWithEmailAndPassword>()));
  gh.singleton<_i16.FlutterSecureStorage>(secureCacheStorage.secureStorage);
  gh.singleton<_i17.LocalStorageAdapter>(_i17.LocalStorageAdapter(
      secureStorage: get<_i16.FlutterSecureStorage>()));
  gh.singleton<_i18.RestClient>(
      _i19.DioAdapter(get<_i17.LocalStorageAdapter>()));
  gh.singleton<_i5.AuthDatasource>(
      _i20.AuthRemoteDatasource(restClient: get<_i18.RestClient>()));
  gh.singleton<_i8.EnterprisesDatasource>(
      _i21.EnterprisesRemoteDatasource(restClient: get<_i18.RestClient>()));
  return get;
}

class _$SecureCacheStorage extends _i22.SecureCacheStorage {}
