import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories', ),
        centerTitle: true,
      ),
      body: Consumer<HomeController>(
        builder: (BuildContext context, HomeController controller, Widget? child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
                child: SizedBox(
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool isSelected = categories[index] == controller.selectedCategory;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: GestureDetector(
                          onTap: () {
                            controller.updateSelectedCategory(categories[index]);
                          },
                          child: IntrinsicWidth(
                            child: Column(
                              children: [
                                Text(
                                  categories[index][0].toUpperCase() +
                                      categories[index].substring(1),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF363636),
                                  ),
                                ),
                                if (isSelected) ...[
                                  SizedBox(height: 4),
                                  Container(height: 2, color: LightColors.primaryColor),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.newsTopHeadlinesList.length,
                  scrollDirection: Axis.vertical,
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
