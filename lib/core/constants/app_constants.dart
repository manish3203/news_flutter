abstract class ApiConstants {
  static const String baseUrl = 'https://newsapi.org/v2';

  static const String topHeadlinesEndpoint = '/top-headlines';

  static const String country = 'us';

  static const int defaultPageSize = 20;

  static const Duration connectTimeout = Duration(seconds: 15);

  static const Duration receiveTimeout = Duration(seconds: 15);
}
