import 'package:get/get.dart';
import 'package:news_18/data/models/article_model.dart';
import 'package:news_18/data/repositories/book_mark_repository.dart';

class BookmarkController extends GetxController {
  final BookmarkRepository repository;

  BookmarkController({required this.repository});

  final RxList<ArticleModel> bookmarks = <ArticleModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    isLoading.value = true;
    try {
      final saved = await repository.getBookmarks();
      bookmarks.assignAll(saved);
    } finally {
      isLoading.value = false;
    }
  }

  bool isBookmarked(ArticleModel article) {
    final key = article.url ?? article.title;
    return bookmarks.any((a) => (a.url ?? a.title) == key);
  }

  Future<void> toggle(ArticleModel article) async {
    if (isBookmarked(article)) {
      await repository.removeBookmark(article);
      bookmarks.removeWhere(
        (a) => (a.url ?? a.title) == (article.url ?? article.title),
      );
    } else {
      await repository.addBookmark(article);
      bookmarks.add(article);
    }
  }
}