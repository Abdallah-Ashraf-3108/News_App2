import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsRepo {
  final ApiService apiService = ApiService();

  Future<List<NewsArticleModel>> getTopHeadlines({
    String? selectedCategory = 'general',
  }) async {
    Map<String, dynamic> result = await apiService.get(
      ApiConfig.topHeadlines,
      params: {"country": "us", "category": selectedCategory},
    );

    return (result["articles"] as List)
        .map((e) => NewsArticleModel.fromJson(e))
        .toList();
  }

  Future<List<NewsArticleModel>> getEverything() async {
    Map<String, dynamic> result = await apiService.get(
      ApiConfig.everything,
      params: {"q": "news", "sortBy": "publishedAt"},
    );

    return (result["articles"] as List)
        .map((e) => NewsArticleModel.fromJson(e))
        .toList();
  }
}
