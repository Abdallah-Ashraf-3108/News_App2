import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';

class ViewAllComponent extends StatelessWidget {
  const ViewAllComponent({
    super.key,
    required this.title,
    this.titleColor,
    required this.onTap,
  });

  final String title;
  final Color? titleColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppSizes.sp16,
              fontWeight: FontWeight.w700,
              color: titleColor ?? Color(0xFFFFFCFC),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () => onTap(),
            child: Text(
              'View all',
              style: TextStyle(
                fontSize: AppSizes.sp14,
                fontWeight: FontWeight.w400,
                color: titleColor ?? Color(0xFFFFFCFC),
                decoration: TextDecoration.underline,
                decorationColor: titleColor ?? Color(0xFFFFFCFC),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
