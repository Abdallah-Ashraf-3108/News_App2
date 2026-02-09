import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.model});
  final NewsArticleModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News Details'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomCachedNetworkImage(
                imagePath: model.urlToImage ?? "",
                height: AppSizes.h240,
                width: double.infinity,
              ),
              SizedBox(height: AppSizes.h16),
              Text(
                model.description ?? '',
                style: TextStyle(
                  fontSize: AppSizes.sp20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: AppSizes.h8),
              Row(
                children: [
                  if (model.urlToImage != null)
                    CircleAvatar(
                      radius: AppSizes.r16,
                      backgroundImage: NetworkImage(model.urlToImage ?? ""),
                    ),
                  SizedBox(width: AppSizes.pw6),
                  Text(
                    (model.author ?? "").substring(
                      0,
                      min((model.author ?? "").length, 10),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppSizes.sp12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF141414),
                    ),
                  ),
                  SizedBox(width: AppSizes.pw8),
                  Text(
                    model.formatDateTime(),
                    style: TextStyle(
                      fontSize: AppSizes.sp14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff363636),
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset('assets/icons/bookmarkIcon.svg'),
                ],
              ),
              SizedBox(height: AppSizes.h16),
              Text(
                model.content ?? "",
                style: TextStyle(
                  fontSize: AppSizes.sp16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
