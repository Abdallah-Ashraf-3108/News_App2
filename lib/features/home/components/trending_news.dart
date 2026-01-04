import 'package:flutter/material.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/light_colors.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: LightColors.primaryColor),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'Trending News',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: LightColors.backgroundColor),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'View all',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: LightColors.backgroundColor,
                            decoration: TextDecoration.underline,
                            decorationColor: LightColors.backgroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 140,
                  child: Consumer<HomeController>(
                    builder: (BuildContext context, HomeController controller, Widget? child) {
                      return (controller.errorMessage?.isNotEmpty ?? false)
                          ? Center(child: Text(controller.errorMessage!))
                          : controller.everythingLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.newsEverythingList.length,
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(width: 12);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  children: [
                                    if (controller.newsEverythingList[index].urlToImage != null)
                                      Image.network(
                                        controller.newsEverythingList[index].urlToImage ?? '',
                                        fit: BoxFit.cover,
                                      ),
                                    // Text(
                                    //   controller.newsEverythingList[index].title!,
                                    //   maxLines: 1,
                                    //   overflow: TextOverflow.ellipsis,
                                    //   style: TextStyle(
                                    //     fontSize: 16,
                                    //     fontWeight: FontWeight.w700,
                                    //     color: LightColors.backgroundColor,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              );
                            },
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
