import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_18/app/routes/app_routes.dart';
import 'package:news_18/feature/home/home_controller.dart';
import 'package:news_18/feature/home/news_status.dart';

import 'widgets/article_card.dart';
import 'widgets/category_tabs.dart';
import 'widgets/error_view.dart';
import 'widgets/loading_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News18',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: const CategoryTabs(),
          ),
        ),
      ),
      body: Obx(() => _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    switch (controller.status.value) {
      case NewsStatus.loading:
        return const LoadingView();

      case NewsStatus.error:
        return ErrorView(
          message: controller.errorMessage.value,
          onRetry: controller.retry,
        );

      case NewsStatus.empty:
        return _buildEmpty(context);

      case NewsStatus.success:
      case NewsStatus.refreshing:
      case NewsStatus.loadingMore:
        return _buildList(context);
    }
  }

  Widget _buildEmpty(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          const Icon(Icons.article_outlined, size: 48, color: Colors.grey),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'No articles found for this category.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refresh,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent - 200) {
            controller.loadMore();
          }
          return false;
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 12, bottom: 24),
          itemCount: controller.articles.length +
              (controller.status.value == NewsStatus.loadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= controller.articles.length) {
              return const LoadingMoreIndicator();
            }
            final article = controller.articles[index];
            return ArticleCard(
              article: article,
              onTap: () {
                Get.toNamed(AppRoutes.articleDetail, arguments: article);
              },
            );
          },
        ),
      ),
    );
  }
}
