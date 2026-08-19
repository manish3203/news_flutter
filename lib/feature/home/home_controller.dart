import 'package:get/get.dart';
import 'package:news_18/core/enums/news_category.dart';
import 'package:news_18/core/network/network_exceptions.dart';
import 'package:news_18/data/models/article_model.dart';
import 'package:news_18/data/repositories/news_repository.dart';
import 'package:news_18/feature/home/news_status.dart';

class HomeController extends GetxController {
  final NewsRepository repository;

  HomeController({required this.repository});

  // ---- Reactive state -----------------------------------------------
  final Rx<NewsCategory> selectedCategory = NewsCategory.all.obs;
  final Rx<NewsStatus> status = NewsStatus.loading.obs;
  final RxList<ArticleModel> articles = <ArticleModel>[].obs;
  final RxString errorMessage = ''.obs;

  int _currentPage = 1;
  bool _hasMore = true;
  static const int _pageSize = 20;

  @override
  void onInit() {
    super.onInit();
    fetchNews(selectedCategory.value);
  }

  /// Called when the user taps a category tab/chip.
  Future<void> selectCategory(NewsCategory category) async {
    if (category == selectedCategory.value && status.value != NewsStatus.error) {
      return;
    }
    selectedCategory.value = category;
    await fetchNews(category);
  }

  /// Loads page 1 for [category]. Set [isRefresh] to keep old data visible
  /// (pull-to-refresh) instead of showing the full-screen loader.
  Future<void> fetchNews(NewsCategory category, {bool isRefresh = false}) async {
    status.value = isRefresh ? NewsStatus.refreshing : NewsStatus.loading;
    errorMessage.value = '';
    _currentPage = 1;
    _hasMore = true;

    try {
      final response = await repository.getTopHeadlines(
        category: category,
        page: _currentPage,
        pageSize: _pageSize,
      );

      articles.assignAll(response.articles);
      _hasMore = response.articles.length >= _pageSize;
      status.value = articles.isEmpty ? NewsStatus.empty : NewsStatus.success;
    } on NetworkException catch (e) {
      errorMessage.value = e.message;
      status.value = NewsStatus.error;
    } catch (_) {
      errorMessage.value = 'Something went wrong. Please try again.';
      status.value = NewsStatus.error;
    }
  }

  /// Infinite-scroll pagination for the currently selected category.
  Future<void> loadMore() async {
    if (!_hasMore || status.value == NewsStatus.loadingMore || status.value == NewsStatus.loading) {
      return;
    }

    final previousStatus = status.value;
    status.value = NewsStatus.loadingMore;

    try {
      final nextPage = _currentPage + 1;
      final response = await repository.getTopHeadlines(
        category: selectedCategory.value,
        page: nextPage,
        pageSize: _pageSize,
      );

      articles.addAll(response.articles);
      _currentPage = nextPage;
      _hasMore = response.articles.length >= _pageSize;
      status.value = NewsStatus.success;
    } on NetworkException catch (_) {
      // Keep existing list visible; just stop the pagination spinner.
      status.value = previousStatus;
    } catch (_) {
      status.value = previousStatus;
    }
  }

  Future<void> retry() => fetchNews(selectedCategory.value);

  @override
  Future<void> refresh() => fetchNews(selectedCategory.value, isRefresh: true);
}
