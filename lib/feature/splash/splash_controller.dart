import 'package:flutter/animation.dart';
import 'package:get/get.dart';

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
    // Title fades in at 0.3s
    await Future.delayed(const Duration(milliseconds: 300));
    showTitle.value = true;

    // Subtitle fades in at 0.6s
    await Future.delayed(const Duration(milliseconds: 300));
    showSubtitle.value = true;

    // Splash shown for 2.5s total, then navigate
    await Future.delayed(const Duration(milliseconds: 1900));
    Get.offAllNamed('/home'); // change route name as needed
  }

  @override
  void onClose() {
    bounceController.dispose();
    super.onClose();
  }
}