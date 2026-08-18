import 'package:dio/dio.dart';
import 'network_exceptions.dart';
import 'network_info.dart';

class ApiClient {
  final Dio dio;
  final NetworkInfo networkInfo;

  ApiClient({required this.networkInfo, String? baseUrl})
      : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? 'https://api.yourapp.com',
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            sendTimeout: const Duration(seconds: 15),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Attach auth token if needed
          // options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          return handler.next(error);
        },
      ),
    );

    // Optional: log requests in debug mode
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
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