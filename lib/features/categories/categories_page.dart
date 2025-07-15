import 'package:algoocean/features/categories/widgets/news_card.dart';
import 'package:algoocean/features/home/controllers/news_controller.dart';
import 'package:algoocean/features/home/widgets/shimmer_news_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final newsController = Get.find<NewsController>();



  Future<void> _refresh() async {
    await newsController.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Categories"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.015,
              horizontal: size.width * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.01),
                SizedBox(
                  height: size.height * 0.05,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: newsController.categories.length,
                    itemBuilder: (context, index) {
                      final category = newsController.categories[index];
                      final isSelected =
                          category == newsController.selectedCategory.value;

                      return Padding(
                        padding: EdgeInsets.only(right: size.width * 0.025),
                        child: GestureDetector(
                          onTap: () {
                            newsController.selectedCategory.value = category;
                            newsController.fetchNews();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: size.height * 0.008,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.black
                                  : Colors.grey[300],
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.03),
                            ),
                            child: Center(
                              child: Text(
                                category.capitalizeFirst!,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
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
            ),
          ),
          Expanded(
            child: Obx(() {
              if (newsController.isLoading.value) {
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  itemCount: 5,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: size.height * 0.015),
                  itemBuilder: (_, __) => ShimmerNewsCard(isWide: isWide),
                );
              }

              final articles = newsController.newsList;

              return RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  itemCount: articles.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: size.height * 0.015),
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return NewsCard(article: article);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
