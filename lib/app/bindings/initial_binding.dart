import 'package:get/get.dart';
import 'package:news_18/data/local_db/book_mark_local_db.dart';
import 'package:news_18/data/repositories/book_mark_repository.dart';
import 'package:news_18/feature/bookmark/bookmark_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BookmarkLocalDataSource>(BookmarkLocalDataSource(), permanent: true);
    Get.put<BookmarkRepository>(
      BookmarkRepositoryImpl(localDataSource: Get.find()),
      permanent: true,
    );
    Get.put<BookmarkController>(
      BookmarkController(repository: Get.find()),
      permanent: true,
    );
  }
}