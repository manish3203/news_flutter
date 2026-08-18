import 'package:freezed_annotation/freezed_annotation.dart';

import 'article_model.dart';

part 'news_response_model.freezed.dart';
part 'news_response_model.g.dart';

@freezed
abstract class NewsResponseModel with _$NewsResponseModel {
  const factory NewsResponseModel({
    String? status,
    int? totalResults,
    @Default([]) List<ArticleModel> articles,
  }) = _NewsResponseModel;

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseModelFromJson(json);
}