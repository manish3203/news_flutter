
import 'package:get/get.dart';
import 'package:news_18/feature/details/article_details_binding.dart';
import 'package:news_18/feature/details/article_details_page.dart';
import 'package:news_18/feature/home/home_binding.dart';
import 'package:news_18/feature/home/home_view.dart';
import 'package:news_18/feature/splash/splash_binding.dart';
import 'package:news_18/feature/splash/splash_view.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = <GetPage>[
    
    GetPage(
      name: AppRoutes.initial,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: AppRoutes.articleDetail,
      page: () => const ArticleDetailPage(),
      binding: ArticleDetailBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}