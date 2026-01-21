import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/categories_screen.dart';
import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/components/top_headlines.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/core/repo/news_repo.dart';
import 'package:provider/provider.dart';
import 'components/trending_news.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController(NewsRepo(ApiService())),
      child: Consumer<HomeController>(
        builder: (
          BuildContext context,
          HomeController controller,
          Widget? child,
        ) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                TrendingNews(),
                SliverToBoxAdapter(
                  child: ViewAllComponent(
                    title: "Categories",
                    titleColor: Color(0xFF141414),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => ChangeNotifierProvider(
                                create:
                                    (_) =>
                                        HomeController(NewsRepo(ApiService())),
                                child: const CategoriesScreen(),
                              ),
                        ),
                      );
                    },
                  ),
                ),
                CategoriesList(),
                TopHeadlines(),
              ],
            ),
          );
        },
      ),
    );
  }
}
