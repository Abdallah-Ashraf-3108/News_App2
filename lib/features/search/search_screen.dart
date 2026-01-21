import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/repo/news_repo.dart';
import 'package:news_app/features/search/controller/search_controller.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return SearchScreenController(NewsRepo(ApiService()));
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Search'), centerTitle: true),
        body: Consumer<SearchScreenController>(
          builder: (
            BuildContext context,
            SearchScreenController controller,
            Widget? child,
          ) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppSizes.pw16),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      controller.getEverything(searchController.text);
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffA0A0A0),
                      ),
                      suffixIcon: Icon(Icons.search, color: Color(0xffA0A0A0)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD3D3D3)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                      controller.newsEverythingList.isEmpty
                          ? Center(child: Text('No articles found'))
                          : ListView.separated(
                            itemCount: controller.newsEverythingList.length,
                            separatorBuilder:
                                (context, index) => Divider(
                                  color: Color(0xffD1DAD6),
                                  indent: 16,
                                  endIndent: 16,
                                ),
                            itemBuilder: (context, index) {
                              final model =
                                  controller.newsEverythingList[index];
                              return ListTile(
                                leading: Icon(
                                  Icons.search,
                                  size: AppSizes.r20,
                                  color: Color(0xff6D6D6D),
                                ),
                                title: Text(
                                  model.title ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                          ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
