import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CustomCachedNetworkImage(
                          imagePath: modelTopHeadlines.urlToImage ?? "",
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              modelTopHeadlines.title ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF141414),
                              ),
                            ),
                            Row(
                              children: [
                                if (modelTopHeadlines.urlToImage != null)
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundImage: NetworkImage(
                                      modelTopHeadlines.urlToImage ?? "",
                                    ),
                                  ),
                                SizedBox(width: 6),
                                Text(
                                  (modelTopHeadlines.author ?? "").substring(
                                    0,
                                    min((modelTopHeadlines.author ?? "").length, 10),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF141414),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  modelTopHeadlines.formatDateTime(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff363636),
                                  ),
                                ),
                                Spacer(),
                                SvgPicture.asset('assets/icons/bookmarkIcon.svg'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
        }
      },
    );
  }
}
