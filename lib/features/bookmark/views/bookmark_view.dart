import 'package:algoocean/features/bookmark/controller/bookmark_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../categories/widgets/news_card.dart';

class BookmarkView extends StatelessWidget {
  final bookmarkController = Get.find<BookmarkController>();
  final RxString searchQuery = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
        automaticallyImplyLeading: false, // 👈 This removes the back button
      ),
      body: Column(
        children: [
          // 🔍 Search Field
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value) => searchQuery.value = value,
              decoration: InputDecoration(
                hintText: 'Search bookmarks...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),

          // 📋 Bookmarks List
          Expanded(
            child: Obx(() {
              final filtered = bookmarkController.bookmarks.where((article) {
                final query = searchQuery.value.toLowerCase();
                return article.title.toLowerCase().contains(query) ||
                    (article.description?.toLowerCase().contains(query) ?? false);
              }).toList();

              if (filtered.isEmpty) {
                return const Center(child: Text("No matching bookmarks found."));
              }

              return ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final article = filtered[index];
                  return NewsCard(article: article);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
