import 'package:news_18/data/local_db/book_mark_local_db.dart';

import '../models/article_model.dart';

abstract class BookmarkRepository {
  Future<List<ArticleModel>> getBookmarks();
  Future<void> addBookmark(ArticleModel article);
  Future<void> removeBookmark(ArticleModel article);
  Future<bool> isBookmarked(ArticleModel article);
}

class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkLocalDataSource localDataSource;

  BookmarkRepositoryImpl({required this.localDataSource});

  /// Unique key per article — url is the natural id; title is a fallback
  /// for mock/dummy data that has no url.
  String _keyFor(ArticleModel article) =>
      (article.url?.isNotEmpty ?? false) ? article.url! : (article.title ?? '');

  @override
  Future<List<ArticleModel>> getBookmarks() async {
    final rawList = await localDataSource.getAll();
    return rawList.map((json) => ArticleModel.fromJson(json)).toList();
  }

  @override
  Future<void> addBookmark(ArticleModel article) {
    return localDataSource.save(_keyFor(article), article.toJson());
  }

  @override
  Future<void> removeBookmark(ArticleModel article) {
    return localDataSource.remove(_keyFor(article));
  }

  @override
  Future<bool> isBookmarked(ArticleModel article) {
    return localDataSource.contains(_keyFor(article));
  }
}