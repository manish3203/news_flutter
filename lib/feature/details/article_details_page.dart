import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_18/feature/details/article_details_controller.dart';


class ArticleDetailPage extends GetView<ArticleDetailController> {
  const ArticleDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final article = controller.article;
    final colors = Theme.of(context).colorScheme;

return Scaffold(
  backgroundColor: colors.surface,
  body: CustomScrollView(
    slivers: [
      SliverAppBar(
        pinned: true,
        backgroundColor: colors.surface.withValues(alpha: 0.9),
        surfaceTintColor: Colors.transparent,
        elevation: 0,

        iconTheme: IconThemeData(
          color: colors.onSurface,
        ),

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colors.onSurface,
          ),
          onPressed: () => Get.back(),
        ),

        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                controller.isBookmarked
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: colors.onSurface,
              ),
              onPressed: controller.toggleBookmark,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.share_outlined,
              color: colors.onSurface,
            ),
            onPressed: controller.shareArticle,
          ),
        ],
      ),

          // ---- Hero image with gradient + category badge + title -------
          SliverToBoxAdapter(
            child: Stack(
              children: [
                SizedBox(
                  height: 320,
                  width: double.infinity,
                  child: (article.urlToImage != null &&
                          article.urlToImage!.isNotEmpty)
                      ? Image.network(
                          article.urlToImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported_outlined,
                                size: 48),
                          ),
                        )
                      : Container(color: Colors.grey[300]),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.8),
                          Colors.black.withValues(alpha: 0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (article.source?.name != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            article.source!.name!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      const SizedBox(height: 10),
                      Text(
                        article.title ?? 'Untitled',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ---- Author row + date ----------------------------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    child: Text(
                      (article.author?.isNotEmpty == true
                              ? article.author![0]
                              : 'N')
                          .toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.author ?? 'Unknown Author',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        Text(
                          article.source?.name ?? '',
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  if (article.publishedAt != null)
                    Text(
                      DateFormat('MMM d, yyyy').format(article.publishedAt!),
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(height: 24, thickness: 1),
          ),

          // ---- Description + body paragraphs -----------------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.description != null &&
                      article.description!.isNotEmpty)
                    Text(
                      article.description!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  const SizedBox(height: 16),
                  ...controller.contentParagraphs.map(
                    (p) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        p,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
