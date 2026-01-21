import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

abstract class BaseNewsRepo {
  Future<List<NewsArticleModel>> getTopHeadlines({
    String? selectedCategory = 'general',
  });
  Future<List<NewsArticleModel>> getEverything({String? query = "news"});
}

class NewsRepo extends BaseNewsRepo {
  NewsRepo(this.apiService);

  final BaseApiService apiService;
  @override
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

  @override
  Future<List<NewsArticleModel>> getEverything({String? query = "news"}) async {
    Map<String, dynamic> result = await apiService.get(
      ApiConfig.everything,
      params: {"q": query, "sortBy": "publishedAt"},
    );

    return (result["articles"] as List)
        .map((e) => NewsArticleModel.fromJson(e))
        .toList();
  }
}
