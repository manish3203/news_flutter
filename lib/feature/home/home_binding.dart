import 'package:get/get.dart';
import 'package:news_18/core/network/api_client.dart';
import 'package:news_18/core/network/network_info.dart';
import 'package:news_18/data/repositories/news_repository.dart';
import 'package:news_18/feature/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl());
    Get.lazyPut<ApiClient>(() => ApiClient(networkInfo: Get.find<NetworkInfo>()));
    Get.lazyPut<NewsRepository>(
      () => NewsRepositoryImpl(apiClient: Get.find<ApiClient>()),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(repository: Get.find<NewsRepository>()),
    );
  }
}
