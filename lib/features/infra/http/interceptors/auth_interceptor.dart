import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../cache/local_storage_adapter.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorageAdapter localStorage;

  AuthInterceptor(this.localStorage);
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path != '/users/auth/sign_in') {
      try {
        final result = await localStorage.fetchSecure('authKey');
        final Map<String, dynamic> authData = jsonDecode(result!);
        options.headers['uid'] = authData['uid'];
        options.headers['client'] = authData['client'];
        options.headers['access-token'] = authData['access-token'];
        options.extra.remove('auth_required');
        return handler.next(options);
      } catch (error) {
        throw FetchCacheException();
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final options = response.requestOptions;

    if (options.path == '/users/auth/sign_in') {
      final headers = response.headers;
      final authData = <String, dynamic>{
        'uid': headers['uid']![0],
        'client': headers['client']![0],
        'access-token': headers['access-token']![0]
      };
      try {
        await localStorage.saveSecure(
          key: 'authKey',
          value: jsonEncode(authData),
        );
      } catch (e) {
        throw SaveCacheException();
      }
    }
    super.onResponse(response, handler);
  }
}
