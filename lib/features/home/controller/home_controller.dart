import 'package:flutter/cupertino.dart';

import '../../../core/datasource/remote_data/api_config.dart';
import '../../../core/datasource/remote_data/api_service.dart';
import '../models/news_article_model.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    getTopHeadlines();
    getEverything();
  }

  List<NewsArticleModel> newsTopHeadlinesList = [];
  List<NewsArticleModel> newsEverythingList = [];
  ApiService apiService = ApiService();
  bool topHeadlinesLoading = true;
  bool everythingLoading = true;
  String? errorMessage;

  void getTopHeadlines() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadlines,
        params: {"country": "us"},
      );

      newsTopHeadlinesList =
          (result["articles"] as List)
              .map((e) => NewsArticleModel.fromJson(e))
              .toList();
      topHeadlinesLoading = false;
      errorMessage = null;
    } catch (e) {
      topHeadlinesLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void getEverything() async {
    try {
      Map<String, dynamic> result = await apiService.get(ApiConfig.everything);

      newsEverythingList =
          (result["articles"] as List)
              .map((e) => NewsArticleModel.fromJson(e))
              .toList();
      everythingLoading = false;
      errorMessage = null;
    } catch (e) {
      everythingLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
