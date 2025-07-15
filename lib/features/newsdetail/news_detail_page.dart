import 'package:algoocean/features/bookmark/controller/bookmark_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';


class NewsDetailPage extends StatelessWidget {
  final dynamic article;
  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bookmarkController = Get.find<BookmarkController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("News Details"),
        actions: [
          Obx(() {
            final isSaved = bookmarkController.isBookmarked(article);
            return IconButton(
              icon: Icon(
                isSaved ? Icons.bookmark : Icons.bookmark_border,
              ),
              onPressed: () {
                bookmarkController.toggleBookmark(article);
              },
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article.urlToImage!,
                  width: double.infinity,
                  height: size.height * 0.25,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: size.height * 0.02),
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              article.source.name,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              DateFormat('MMM dd, yyyy • hh:mm a')
                  .format(DateTime.parse(article.publishedAt)),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: size.height * 0.025),
            Text(
              article.description ?? 'No description available.',
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            if (article.content != null)
              Html(data: article.content),
          ],
        ),
      ),
    );
  }
}
