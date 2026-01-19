import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    required this.title,
    this.suffix,
    this.maxLines = 1,
    this.obscureText = false,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? title;
  final Widget? suffix;
  final int? maxLines;
  final bool obscureText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title ?? "",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppSizes.sp16),
          ),
          TextFormField(
            maxLines: widget.maxLines,
            controller: widget.controller,
            obscureText: widget.obscureText && !_isVisible,
            validator:
                widget.validator != null
                    ? (value) => widget.validator!(value)
                    : null,
            decoration: InputDecoration(
              hintText: widget.hintText,
              suffixIcon:
                  widget.obscureText
                      ? IconButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        icon:
                            _isVisible
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                      )
                      : widget.suffix,
            ),
          ),
        ],
      ),
    );
  }
}
