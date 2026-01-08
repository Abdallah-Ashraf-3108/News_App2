import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});

  final NewsArticleModel model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomCachedNetworkImage(imagePath: model.urlToImage ?? ""),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title ?? "",
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
                    if (model.urlToImage != null)
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(model.urlToImage ?? ""),
                      ),
                    SizedBox(width: 6),
                    Text(
                      (model.author ?? "").substring(0, min((model.author ?? "").length, 10)),
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
                      model.formatDateTime(),
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
  }
}
