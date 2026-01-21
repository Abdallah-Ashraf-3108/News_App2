import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/repo/news_repo.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class SearchScreenController extends ChangeNotifier with SafeNotifyMixin {
  SearchScreenController(this.newsRepo);

  final BaseNewsRepo newsRepo;
  List<NewsArticleModel> newsEverythingList = [];
  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  String? errorMessage;

  void getEverything(String query) async {
    try {
      newsEverythingList = await newsRepo.getEverything(query: query);

      everythingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      everythingStatus = RequestStatusEnum.error;
    }
    safeNotify();
  }
}
