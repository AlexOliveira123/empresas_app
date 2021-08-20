import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../cache/local_storage_adapter.dart';
import 'interceptors/auth_interceptor.dart';
import 'rest_client.dart';
import 'rest_client_exception.dart';
import 'rest_client_response.dart';

@Singleton(as: RestClient)
class DioAdapter implements RestClient {
  late Dio _dio;
  final LocalStorageAdapter localStorage;

  final _baseOptions = BaseOptions(
    baseUrl: dotenv.env['baseUrl']!,
    connectTimeout: 60000,
    receiveTimeout: 60000,
    contentType: 'application/json',
  );

  DioAdapter(this.localStorage) {
    _dio = Dio(_baseOptions);
    _dio.interceptors.addAll([
      AuthInterceptor(this.localStorage),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      )
    ]);
  }

  @override
  Future<RestClientResponse<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        message: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        error: e.error,
      );
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        message: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        error: e.error,
      );
    }
  }
}
