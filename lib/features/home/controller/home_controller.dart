import 'package:flutter/cupertino.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/repo/news_repo.dart';
import '../../../core/enums/request_status_enum.dart';
import '../models/news_article_model.dart';

class HomeController extends ChangeNotifier with SafeNotifyMixin {
  HomeController(this.newsRepo) {
    getTopHeadlines();
    getEverything();
  }

  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadlinesStatus = RequestStatusEnum.loading;

  List<NewsArticleModel> newsTopHeadlinesList = [];
  List<NewsArticleModel> newsEverythingList = [];
  final BaseNewsRepo newsRepo;
  String? errorMessage;
  String? selectedCategory;

  void getTopHeadlines({String? category}) async {
    try {
      topHeadlinesStatus = RequestStatusEnum.loading;
      safeNotify();

      newsTopHeadlinesList = await newsRepo.getTopHeadlines(
        selectedCategory: selectedCategory,
      );
      topHeadlinesStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      topHeadlinesStatus = RequestStatusEnum.error;
    }
    safeNotify();
  }

  void getEverything() async {
    try {
      newsEverythingList = await newsRepo.getEverything();

      everythingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      everythingStatus = RequestStatusEnum.error;
    }
    safeNotify();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadlines(category: selectedCategory);
    safeNotify();
  }
}
