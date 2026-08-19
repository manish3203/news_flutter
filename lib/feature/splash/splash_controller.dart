import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:news_18/app/routes/app_routes.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController bounceController;
  late final Animation<double> bounceAnimation;

  final RxBool showTitle = false.obs;
  final RxBool showSubtitle = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Icon bounce loop (equivalent to CSS animate-bounce)
    bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    bounceAnimation = CurvedAnimation(
      parent: bounceController,
      curve: Curves.easeInOut,
    );

    _runSequence();
  }

  Future<void> _runSequence() async {
    await Future.delayed(const Duration(milliseconds: 300));
    showTitle.value = true;

    await Future.delayed(const Duration(milliseconds: 300));
    showSubtitle.value = true;

    await Future.delayed(const Duration(milliseconds: 1900));
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  void onClose() {
    bounceController.dispose();
    super.onClose();
  }
}