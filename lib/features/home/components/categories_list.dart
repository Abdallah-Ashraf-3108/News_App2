import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: AppSizes.pw12, top: AppSizes.ph12, bottom: AppSizes.ph12),
        child: SizedBox(
          height: AppSizes.h30,
          child: Consumer<HomeController>(
            builder: (BuildContext context, HomeController controller, Widget? child) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  bool isSelected = categories[index] == controller.selectedCategory;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.pw12),
                    child: GestureDetector(
                      onTap: () {
                        controller.updateSelectedCategory(categories[index]);
                      },
                      child: IntrinsicWidth(
                        child: Column(
                          children: [
                            Text(
                              categories[index][0].toUpperCase() + categories[index].substring(1),
                              style: TextStyle(
                                fontSize: AppSizes.sp16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF363636),
                              ),
                            ),
                            if (isSelected) ...[
                              SizedBox(height: AppSizes.ph4),
                              Container(height: AppSizes.h2, color: LightColors.primaryColor),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

final List<String> categories = [
  "general",
  "business",
  "entertainment",
  "health",
  "science",
  "sports",
  "technology",
];
