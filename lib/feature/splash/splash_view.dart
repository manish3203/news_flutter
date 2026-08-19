import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F172A) : const Color(0xFF2563EB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bouncing icon
            AnimatedBuilder(
              animation: controller.bounceAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    -16 * controller.bounceAnimation.value,
                  ),
                  child: child,
                );
              },
              child: const Icon(
                Icons.newspaper_rounded,
                size: 96,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            // Title: "NewsNow."
            Obx(
              () => AnimatedOpacity(
                opacity: controller.showTitle.value ? 1 : 0,
                duration: const Duration(milliseconds: 700),
                child: AnimatedSlide(
                  offset: controller.showTitle.value
                      ? Offset.zero
                      : const Offset(0, 0.3),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                  child: const Text(
                    'News18',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Subtitle
            Obx(
              () => AnimatedOpacity(
                opacity: controller.showSubtitle.value ? 1 : 0,
                duration: const Duration(milliseconds: 700),
                child: AnimatedSlide(
                  offset: controller.showSubtitle.value
                      ? Offset.zero
                      : const Offset(0, 0.3),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                  child: Text(
                    'Stay informed, everywhere.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue.shade100,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}