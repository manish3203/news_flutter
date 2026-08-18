
import 'package:get/get.dart';
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
  ];
}