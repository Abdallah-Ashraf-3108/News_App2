import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/constants/app_sizes.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.leading,
    this.onTap,
    this.iconColor,
    this.textColor,
  });
  final String title;
  final Widget leading;
  final Color? iconColor;
  final Color? textColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: TextStyle(
              fontSize: AppSizes.sp16,
              fontWeight: FontWeight.w400,
            ),
          ),
          textColor: textColor,
          leading: leading,
          iconColor: iconColor,
          trailing: Icon(Icons.arrow_forward_ios_outlined),
        ),

        Divider(color: Color(0xffD1DAD6), indent: 8.w, endIndent: 8.w),
      ],
    );
  }
}
