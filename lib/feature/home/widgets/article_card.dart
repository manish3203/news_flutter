import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_18/data/models/article_model.dart';
import 'package:news_18/feature/bookmark/bookmark_controller.dart';

class ArticleCard extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback? onTap;

  const ArticleCard({super.key, required this.article, this.onTap});

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  article.urlToImage!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported_outlined),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          article.source?.name ?? 'Unknown source',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      const Text(' • ', style: TextStyle(color: Colors.grey)),
                      Text(
                        _formatDate(article.publishedAt),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.title ?? 'Untitled',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.2),
                  ),
                  if (article.description != null && article.description!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      article.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                  ],
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Obx(() {
                      final bookmarkController = Get.find<BookmarkController>();
                      final saved = bookmarkController.isBookmarked(article);
                      return IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          saved ? Icons.bookmark : Icons.bookmark_border,
                          color: saved ? Theme.of(context).colorScheme.primary : Colors.grey[500],
                        ),
                        onPressed: () => bookmarkController.toggle(article),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}