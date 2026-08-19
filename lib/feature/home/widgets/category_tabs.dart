import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_18/core/enums/news_category.dart';
import 'package:news_18/feature/home/home_controller.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: NewsCategory.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = NewsCategory.values[index];

          return Obx(() {
            final isSelected = controller.selectedCategory.value == category;

            return ChoiceChip(
              label: Text(category.label),
              selected: isSelected,
              onSelected: (_) => controller.selectCategory(category),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              selectedColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide.none,
              ),
              showCheckmark: false,
            );
          });
        },
      ),
    );
  }
}