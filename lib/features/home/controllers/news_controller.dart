import 'package:algoocean/features/home/data/models/news_model.dart';
import 'package:get/get.dart';
import '../../../core/services/news_service.dart';


class NewsController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxList<NewsModel> newsList = <NewsModel>[].obs;
  final NewsService _service = NewsService();



  final List<String> categories = [
  'business',
  'entertainment',
  'general',
  'health',
  'science',
  'sports',
  'technology',
];

final RxString selectedCategory = 'general'.obs;


  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

Future<void> fetchNews() async {
  try {
    isLoading.value = true;
    final data = await _service.fetchNewsByCategory(selectedCategory.value);
    newsList.value = data;
    update();
  } catch (e) {
    print('Error: $e');
  } finally {
    isLoading.value = false;
     update();
  }
}


}
