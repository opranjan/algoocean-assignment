import 'package:algoocean/features/home/controllers/news_controller.dart';
import 'package:algoocean/features/categories/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final newsController = Get.find<NewsController>();
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    newsController.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search News"),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search news...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.trim().toLowerCase();
                });
              },
            ),
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: Obx(() {
                final filteredNews = newsController.newsList.where((article) {
                  final title = article.title?.toLowerCase() ?? '';
                  return title.contains(searchQuery);
                }).toList();

                if (filteredNews.isEmpty) {
                  return const Center(child: Text('No news found.'));
                }

                return ListView.separated(
                  itemCount: filteredNews.length,
                  separatorBuilder: (_, __) => SizedBox(height: size.height * 0.015),
                  itemBuilder: (context, index) {
                    return NewsCard(article: filteredNews[index]);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
