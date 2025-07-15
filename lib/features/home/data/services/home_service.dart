import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/top_heading_model.dart';

class HomeService {
  final Dio _dio = DioClient().dio;

  Future<List<NewsArticle>> fetchTopHeadlines({String country = 'us'}) async {
    try {
      final response = await _dio.get(
        ApiConstants.topHeadlines,
        queryParameters: {
          'country': country,
          'apiKey': ApiConstants.apiKey,
        },
      );

      final List articles = response.data['articles'];
      return articles.map((e) => NewsArticle.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception("HomeService Error: ${e.message}");
    }
  }
}
