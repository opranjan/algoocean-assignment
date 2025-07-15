import 'package:algoocean/features/categories/categories_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';

class CategoryChips extends StatefulWidget {
  const CategoryChips({super.key});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  final newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: isWide ? 18 : 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => const CategoriesPage());
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: isWide ? 14 : 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).highlightColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            itemCount: newsController.categories.length,
            itemBuilder: (context, index) {
              final category = newsController.categories[index];
              final isSelected = category == newsController.selectedCategory.value;

              return Padding(
                padding: EdgeInsets.only(right: size.width * 0.025),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      newsController.selectedCategory.value = category;
                      newsController.fetchNews();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.008,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.black : Colors.grey[300],
                      borderRadius: BorderRadius.circular(size.width * 0.03),
                      border: Border.all(width: 1, color: Theme.of(context).highlightColor)
                    ),
                    child: Center(
                      child: Text(
                        category.capitalizeFirst!,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: isWide ? 16 : 14,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
