
import 'package:algoocean/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:algoocean/core/constants/api_constants.dart';
import 'package:algoocean/features/home/data/models/news_model.dart';

class NewsService {
  final Dio _dio = DioClient().dio; // Use DioClient here
  final String _apiKey = ApiConstants.apiKey.toString();

  Future<List<NewsModel>> fetchNewsByCategory(String category) async {
    try {
      final response = await _dio.get(
        ApiConstants.everything,
        queryParameters: {
          'q': category,
          'apiKey': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final articles = response.data['articles'] as List;
        return articles.map((e) => NewsModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch news');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}

