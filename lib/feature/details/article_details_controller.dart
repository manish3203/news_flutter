import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:news_18/feature/bookmark/bookmark_controller.dart';
import '../../data/models/article_model.dart';

class ArticleDetailController extends GetxController {
  final ArticleModel article;
  final BookmarkController bookmarkController = Get.find<BookmarkController>();

  ArticleDetailController({required this.article});

  
  bool get isBookmarked => bookmarkController.isBookmarked(article);

  Future<void> toggleBookmark() => bookmarkController.toggle(article);

  Future<void> shareArticle() async {
    final url = article.url;
    if (url != null && url.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: url));
      Get.snackbar('Copied', 'Article link copied to clipboard',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      await Clipboard.setData(ClipboardData(text: article.title ?? ''));
      Get.snackbar('Copied', 'Article title copied to clipboard',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  List<String> get contentParagraphs {
    final content = article.content;
    if (content == null || content.isEmpty) return [];
    return content
        .split('. ')
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .map((p) => p.endsWith('.') ? p : '$p.')
        .toList();
  }
}