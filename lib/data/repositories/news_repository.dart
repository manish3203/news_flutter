import 'package:news_18/core/constants/app_constants.dart';
import 'package:news_18/core/enums/news_category.dart';
import '../../core/network/api_client.dart';
import '../../core/network/network_exceptions.dart';
import '../models/news_response_model.dart';

abstract class NewsRepository {
  Future<NewsResponseModel> getTopHeadlines({
    required NewsCategory category,
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
  });
}

class NewsRepositoryImpl implements NewsRepository {
  final ApiClient apiClient;

  NewsRepositoryImpl({required this.apiClient});

  @override
  Future<NewsResponseModel> getTopHeadlines({
    required NewsCategory category,
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
  }) async {
    final queryParameters = <String, dynamic>{
      'country': ApiConstants.country,
      'page': page,
      'pageSize': pageSize,
      if (category.apiValue != null) 'category': category.apiValue,
    };

    final response = await apiClient.get(
      ApiConstants.topHeadlinesEndpoint,
      queryParameters: queryParameters,
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw NetworkException('Received an unexpected response from the server.');
    }

    final result = NewsResponseModel.fromJson(data);

    if (result.status == 'error') {
      throw NetworkException('Failed to load news.');
    }

    return result;
  }
}
