import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/home/components/trending_news_shimmer.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/theme/light_colors.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 330,
        child: Stack(
          children: [
            SizedBox(
              height: 240,
              width: double.infinity,
              child: Image.asset('assets/images/home_background.png', fit: BoxFit.cover),
            ),
            Positioned.fill(
              top: 60,
              child: Column(
                children: [
                  Text(
                    'NEWST',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: LightColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 14),
                  ViewAllComponent(title: "Trending News", onTap: () {}),
                  SizedBox(height: 16),

                  SizedBox(
                    height: 140,
                    child: Consumer<HomeController>(
                      builder: (BuildContext context, HomeController controller, Widget? child) {
                        switch (controller.everythingStatus) {
                          case RequestStatusEnum.loading:
                            return TrendingNewsShimmer();
                          case RequestStatusEnum.error:
                            return Center(child: Text(controller.errorMessage!));
                          case RequestStatusEnum.loaded:
                            return ListView.separated(
                              padding: EdgeInsets.only(left: 16),
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.newsEverythingList.take(10).length,
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(width: 12),
                              itemBuilder: (BuildContext context, int index) {
                                final modelEverything = controller.newsEverythingList[index];
                                return SizedBox(
                                  width: 240,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Stack(
                                      children: [
                                        CustomCachedNetworkImage(
                                          imagePath: modelEverything.urlToImage ?? "",
                                          width: 240,
                                          height: 140,
                                        ),
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.black.withValues(alpha: 0.1),
                                                  Colors.black.withValues(alpha: 0.9),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 12,
                                          right: 12,
                                          left: 12,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                modelEverything.title!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: LightColors.backgroundColor,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 10,
                                                    backgroundImage: NetworkImage(
                                                      modelEverything.urlToImage ?? "",
                                                    ),
                                                  ),
                                                  SizedBox(width: 6),
                                                  Expanded(
                                                    child: Text(
                                                      modelEverything.author ?? "",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        color: LightColors.backgroundColor,
                                                      ),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    modelEverything.formatDateTime(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: LightColors.backgroundColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
