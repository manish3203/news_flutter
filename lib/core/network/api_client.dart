import 'package:dio/dio.dart';
import 'package:news_18/core/config/env_config.dart';
import 'package:news_18/core/constants/app_constants.dart';
import 'network_exceptions.dart';
import 'network_info.dart';

class ApiClient {
  final Dio dio;
  final NetworkInfo networkInfo;

  ApiClient({required this.networkInfo, String? baseUrl})
      : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? ApiConstants.baseUrl,
            connectTimeout: ApiConstants.connectTimeout,
            receiveTimeout: ApiConstants.receiveTimeout,
            sendTimeout: ApiConstants.connectTimeout,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // NewsAPI accepts the key as a query param (or X-Api-Key header).
          options.queryParameters.putIfAbsent(
            'apiKey',
            () => EnvConfig.newsApiKey,
          );
          return handler.next(options);
        },
        onResponse: (response, handler) => handler.next(response),
        onError: (DioException error, handler) => handler.next(error),
      ),
    );

    assert(() {
      dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestBody: true,
          responseBody: true,
          error: true,
        ),
      );
      return true;
    }());
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    await _checkConnection();
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    await _checkConnection();
    try {
      return await dio.post(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    await _checkConnection();
    try {
      return await dio.put(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    await _checkConnection();
    try {
      return await dio.delete(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  Future<void> _checkConnection() async {
    if (!await networkInfo.isConnected) {
      throw NetworkException('No internet connection.');
    }
  }
}
