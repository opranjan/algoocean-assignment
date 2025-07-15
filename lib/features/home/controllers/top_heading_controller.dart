import 'package:get/get.dart';
import '../data/services/home_service.dart';
import '../data/models/top_heading_model.dart';

class TopHeadingController extends GetxController {
  final HomeService _homeService = HomeService();
  final headlines = <NewsArticle>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchTopHeadlines();
    super.onInit();
  }

  void fetchTopHeadlines() async {
    isLoading.value = true;
    try {
      final data = await _homeService.fetchTopHeadlines();
      headlines.assignAll(data);
    } catch (e) {
      print('HomeController Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
