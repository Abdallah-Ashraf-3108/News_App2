import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.h48,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading ? CircularProgressIndicator() : Text(text),
      ),
    );
  }
}
