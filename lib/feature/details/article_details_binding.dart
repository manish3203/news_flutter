import 'package:get/get.dart';
import 'package:news_18/feature/details/article_details_controller.dart';

import '../../data/models/article_model.dart';

class ArticleDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Get.arguments is whatever was passed to Get.toNamed()/Get.to().
    final article = Get.arguments as ArticleModel;

    Get.lazyPut<ArticleDetailController>(
      () => ArticleDetailController(article: article),
    );
  }
}
