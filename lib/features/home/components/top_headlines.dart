import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/components/top_headlines_shimmer.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';
class TopHeadlines extends StatelessWidget {
  const TopHeadlines({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, Widget? child) {
        switch (controller.topHeadlinesStatus) {
          case RequestStatusEnum.loading:
            return TopHeadlinesShimmer();
          case RequestStatusEnum.error:
            return SliverToBoxAdapter(child: Center(child: Text(controller.errorMessage!)));
          case RequestStatusEnum.loaded:
            return SliverList.builder(
              itemCount: controller.newsTopHeadlinesList.length,
              itemBuilder: (BuildContext context, int index) {
                final modelTopHeadlines = controller.newsTopHeadlinesList[index];
                return NewsItem(model: modelTopHeadlines);
              },
            );
        }
      },
    );
  }
}
