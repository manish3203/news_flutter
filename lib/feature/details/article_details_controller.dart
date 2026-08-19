import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../data/models/article_model.dart';

class ArticleDetailController extends GetxController {
  /// The article is passed in via route arguments — see ArticleDetailBinding.
  final ArticleModel article;

  /// Local reactive bookmark flag. Wire this up to a shared
  /// BookmarkService/HomeController list once you add bookmarking —
  /// for now it's local to this screen so the icon just toggles.
  final RxBool isBookmarked = false.obs;

  ArticleDetailController({required this.article});

  void toggleBookmark() {
    isBookmarked.value = !isBookmarked.value;
    // TODO: persist / sync with your bookmarks list, e.g.
    // Get.find<BookmarkController>().toggle(article);
  }

  Future<void> shareArticle() async {
    final url = article.url;
    if (url != null && url.isNotEmpty) {
      // If you add the share_plus package: await Share.share(url, subject: article.title);
      await Clipboard.setData(ClipboardData(text: url));
      Get.snackbar('Copied', 'Article link copied to clipboard',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      await Clipboard.setData(ClipboardData(text: article.title ?? ''));
      Get.snackbar('Copied', 'Article title copied to clipboard',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Splits content into paragraphs (mirrors the React mock's ". " split).
  /// Swap this out once you're rendering real article bodies.
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
