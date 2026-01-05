import 'package:flutter/cupertino.dart';

import '../../../core/datasource/remote_data/api_config.dart';
import '../../../core/datasource/remote_data/api_service.dart';
import '../../../core/enums/request_status_enum.dart';
import '../models/news_article_model.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    getTopHeadlines();
    getEverything();
  }

  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadlinesStatus = RequestStatusEnum.loading;

  List<NewsArticleModel> newsTopHeadlinesList = [];
  List<NewsArticleModel> newsEverythingList = [];
  ApiService apiService = ApiService();
  String? errorMessage;

  String? selectedCategory;

  void getTopHeadlines({String? category}) async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadlines,
        params: {"country": "us", "category": selectedCategory},
      );

      newsTopHeadlinesList =
          (result["articles"] as List)
              .map((e) => NewsArticleModel.fromJson(e))
              .toList();
      topHeadlinesStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      topHeadlinesStatus = RequestStatusEnum.error;
    }
    notifyListeners();
  }

  void getEverything() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.everything,
        params: {"q": "news", "sortBy": "publishedAt"},
      );

      newsEverythingList =
          (result["articles"] as List)
              .map((e) => NewsArticleModel.fromJson(e))
              .toList();
      everythingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      everythingStatus = RequestStatusEnum.error;
    }
    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadlines(category: selectedCategory);
    notifyListeners();
  }
}
