import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_18/app/routes/app_routes.dart';
import 'package:news_18/feature/bookmark/bookmark_controller.dart';
import 'package:news_18/feature/home/widgets/article_card.dart';


class BookmarksView extends StatelessWidget {
  const BookmarksView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookmarkController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Articles')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.bookmarks.isEmpty) {
          return const Center(
            child: Text(
              'No saved articles yet.\nTap the bookmark icon on any article to save it here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 12, bottom: 24),
          itemCount: controller.bookmarks.length,
          itemBuilder: (context, index) {
            final article = controller.bookmarks[index];
            return Dismissible(
              key: ValueKey(article.url ?? article.title),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 24),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.delete_outline, color: Colors.white),
              ),
              onDismissed: (_) => controller.toggle(article),
              child: ArticleCard(
                article: article,
                onTap: () => Get.toNamed(AppRoutes.articleDetail, arguments: article),
              ),
            );
          },
        );
      }),
       bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (index) {
          if (index == 0) Get.back(); // or Get.offNamed(Routes.home)
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.bookmark_border), selectedIcon: Icon(Icons.bookmark), label: 'Saved'),
        ],
      ),
    );
  }
}