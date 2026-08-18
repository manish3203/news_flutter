import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  NetworkException(this.message, {this.statusCode});

  @override
  String toString() => message;

  factory NetworkException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('Connection timed out. Please try again.');

      case DioExceptionType.badCertificate:
        return NetworkException('Security certificate error.');

      case DioExceptionType.badResponse:
        return NetworkException.fromStatusCode(
          error.response?.statusCode,
          error.response?.data,
        );

      case DioExceptionType.cancel:
        return NetworkException('Request was cancelled.');

      case DioExceptionType.connectionError:
        return NetworkException('No internet connection.');

      case DioExceptionType.unknown:
        return NetworkException('Something went wrong. Please try again.');
      case DioExceptionType.transformTimeout:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  factory NetworkException.fromStatusCode(int? statusCode, dynamic data) {
    String message = 'Something went wrong.';

    if (data is Map && data['message'] != null) {
      message = data['message'].toString();
    }

    switch (statusCode) {
      case 400:
        return NetworkException(message.isNotEmpty ? message : 'Bad request.', statusCode: 400);
      case 401:
        return NetworkException('Unauthorized. Please log in again.', statusCode: 401);
      case 403:
        return NetworkException('Access forbidden.', statusCode: 403);
      case 404:
        return NetworkException('Resource not found.', statusCode: 404);
      case 422:
        return NetworkException(message, statusCode: 422);
      case 500:
        return NetworkException('Server error. Please try again later.', statusCode: 500);
      default:
        return NetworkException(message, statusCode: statusCode);
    }
  }
}