import 'dart:convert';
import 'package:algoocean/features/home/data/models/news_model.dart';
import 'package:algoocean/features/home/data/models/top_heading_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkController extends GetxController {
  final RxList<dynamic> bookmarks = <dynamic>[].obs; // NewsModel or NewsArticle

  static const String _key = 'bookmarks';

  @override
  void onInit() {
    super.onInit();
    loadBookmarks();
  }

  void toggleBookmark(dynamic article) async {
    if (isBookmarked(article)) {
      bookmarks.removeWhere((a) => a.url == article.url);
    } else {
      bookmarks.add(article);
    }
    await saveBookmarks();
  }

  bool isBookmarked(dynamic article) {
    return bookmarks.any((a) => a.url == article.url);
  }

  Future<void> saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = bookmarks.map((e) {
      final json = e.toJson();
      json['__type'] = e.runtimeType.toString(); // e.g., "NewsModel" or "NewsArticle"
      return jsonEncode(json);
    }).toList();

    await prefs.setStringList(_key, jsonList);
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_key);

    if (jsonList != null) {
      final List<dynamic> loaded = jsonList.map((jsonStr) {
        final Map<String, dynamic> map = jsonDecode(jsonStr);
        final String? type = map['__type'];

        map.remove('__type'); // clean up

        if (type == 'NewsArticle') {
          return NewsArticle.fromJson(map);
        } else {
          return NewsModel.fromJson(map);
        }
      }).toList();

      bookmarks.assignAll(loaded);
    }
  }
}
