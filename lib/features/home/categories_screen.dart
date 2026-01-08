import 'package:flutter/material.dart';
import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories'), centerTitle: true),
      body: Consumer<HomeController>(
        builder: (BuildContext context, HomeController controller, Widget? child) {
          return CustomScrollView(
            slivers: [
              CategoriesList(),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final model = controller.newsTopHeadlinesList[index];
                  return NewsItem(model: model);
                }, childCount: controller.newsTopHeadlinesList.length),
              ),
            ],
          );
        },
      ),
    );
  }
}
