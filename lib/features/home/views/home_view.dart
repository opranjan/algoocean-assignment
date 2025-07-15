import 'package:algoocean/features/home/widgets/category_chips.dart';
import 'package:algoocean/features/home/widgets/shimmer_headline_card.dart';
import 'package:algoocean/features/home/widgets/shimmer_news_card.dart';
import 'package:algoocean/features/newsdetail/news_detail_page.dart';
import 'package:algoocean/features/search/search_page.dart';
import 'package:algoocean/themes/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/news_controller.dart';
import '../controllers/top_heading_controller.dart';

class HomeView extends StatelessWidget {
  final TopHeadingController topHeadingController = Get.put(
    TopHeadingController(),
  );
  final NewsController newsController = Get.put(NewsController());

  HomeView({super.key});

  Future<void> _onRefresh() async {
    topHeadingController.fetchTopHeadlines();
    newsController.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // 🔒 Static Header - Not Scrollable
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.015,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Newsly',
                    style: TextStyle(
                      fontSize: isWide ? 28 : 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).highlightColor
                    ),
                  ),

                  Row(
                    children: [
                      IconButton(
                        icon: Obx(() {
                          final isDark =
                              Get.find<ThemeController>().isDarkMode.value;
                          return Icon(
                            isDark ? Icons.dark_mode : Icons.light_mode,
                          );
                        }),
                        onPressed:
                            () => Get.find<ThemeController>().toggleTheme(),
                      ),
                      Icon(Icons.notifications_none, size: isWide ? 28 : 24),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Container(
                height: size.height * 0.06,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(size.width * 0.03),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.to(() => SearchPage()),
                        child: Text(
                          'Search for news',
                          style: TextStyle(
                            fontSize: isWide ? 18 : 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.tune,
                      color: Colors.grey,
                      size: isWide ? 26 : 22,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),

            // 🔄 Scrollable Content with RefreshIndicator
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(child: CategoryChips()),
                    SliverToBoxAdapter(
                      child: SizedBox(height: size.height * 0.02),
                    ),

                    // 🔹 Horizontal News Section
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'News',
                              style: TextStyle(
                                fontSize: isWide ? 20 : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: size.height * 0.01),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: isWide ? 180 : 140,
                        child: Obx(() {
                          if (newsController.isLoading.value) {
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04,
                              ),
                              itemCount: 5,
                              separatorBuilder:
                                  (_, __) => SizedBox(width: size.width * 0.03),
                              itemBuilder:
                                  (_, __) => ShimmerNewsCard(isWide: isWide),
                            );
                          }

                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                            ),
                            itemCount: newsController.newsList.length.clamp(
                              0,
                              10,
                            ),
                            separatorBuilder:
                                (_, __) => SizedBox(width: size.width * 0.03),
                            itemBuilder: (context, index) {
                              final article = newsController.newsList[index];
                              return GestureDetector(
                                onTap:
                                    () => Get.to(
                                      () => NewsDetailPage(article: article),
                                    ),
                                child: Container(
                                  width: isWide ? 240 : 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      size.width * 0.03,
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        article.urlToImage.toString(),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        size.width * 0.03,
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.6),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                    padding: EdgeInsets.all(size.width * 0.03),
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      article.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: isWide ? 16 : 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: SizedBox(height: size.height * 0.02),
                    ),

                    // 🔹 Top Headlines Section
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Top Headlines',
                              style: TextStyle(
                                fontSize: isWide ? 20 : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: size.height * 0.01),
                    ),
                    Obx(() {
                      if (topHeadingController.isLoading.value) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (_, __) => ShimmerHeadlineCard(isWide: isWide),
                            childCount: 5,
                          ),
                        );
                      }

                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final article = topHeadingController.headlines[index];
                          return GestureDetector(
                            onTap:
                                () => Get.to(
                                  () => NewsDetailPage(article: article),
                                ),
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: size.height * 0.015,
                                left: size.width * 0.04,
                                right: size.width * 0.04,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(
                                  size.width * 0.03,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                        size.width * 0.03,
                                      ),
                                      bottomLeft: Radius.circular(
                                        size.width * 0.03,
                                      ),
                                    ),
                                    child: Image.network(
                                      article.urlToImage.toString(),
                                      height: isWide ? 130 : 90,
                                      width: isWide ? 160 : 110,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (_, __, ___) => Container(
                                            height: isWide ? 130 : 90,
                                            width: isWide ? 160 : 110,
                                            color: Colors.grey[300],
                                            child: const Icon(
                                              Icons.image_not_supported,
                                            ),
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                        size.width * 0.03,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            article.title,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: isWide ? 18 : 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: size.height * 0.008),
                                          Text(
                                            article.source.toString(),
                                            style: TextStyle(
                                              fontSize: isWide ? 14 : 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: size.height * 0.005),
                                          Text(
                                            article.publishedAt
                                                .split('T')
                                                .first,
                                            style: TextStyle(
                                              fontSize: isWide ? 12 : 10,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }, childCount: topHeadingController.headlines.length),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
