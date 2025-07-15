import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  // static const String apiKey = 'd9c4cf00101248728e8e8856f3056430';
  static final apiKey = dotenv.env['NEWS_API_KEY'];
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String topHeadlines = '/top-headlines';
  static const String everything = '/everything';
}
