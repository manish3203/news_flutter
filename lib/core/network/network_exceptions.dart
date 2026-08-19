import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  NetworkException(this.message, {this.statusCode});

  factory NetworkException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          'The connection timed out. Please try again.',
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          'No internet connection. Please check your network.',
        );
      case DioExceptionType.badCertificate:
        return NetworkException('A secure connection could not be established.');
      case DioExceptionType.cancel:
        return NetworkException('The request was cancelled.');
      case DioExceptionType.badResponse:
        return _fromResponse(error);
      case DioExceptionType.unknown:
        return NetworkException(
          error.message ?? 'An unexpected error occurred. Please try again.',
        );
      case DioExceptionType.transformTimeout:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  static NetworkException _fromResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    String? apiMessage;
    if (data is Map && data['message'] is String) {
      apiMessage = data['message'] as String;
    }

    switch (statusCode) {
      case 400:
        return NetworkException(
          apiMessage ?? 'Bad request. Please check the parameters and try again.',
          statusCode: statusCode,
        );
      case 401:
        return NetworkException(
          apiMessage ?? 'Invalid or missing API key.',
          statusCode: statusCode,
        );
      case 426:
        return NetworkException(
          apiMessage ?? 'This request requires an upgraded API plan.',
          statusCode: statusCode,
        );
      case 429:
        return NetworkException(
          apiMessage ?? 'Too many requests. Please slow down and try again.',
          statusCode: statusCode,
        );
      case 500:
      case 502:
      case 503:
        return NetworkException(
          'Something went wrong on the server. Please try again shortly.',
          statusCode: statusCode,
        );
      default:
        return NetworkException(
          apiMessage ?? 'Something went wrong. Please try again.',
          statusCode: statusCode,
        );
    }
  }

  @override
  String toString() => message;
}
