import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/core/widgets/custom_elevated_button.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';

class ProfileBottomSheet extends StatefulWidget {
  const ProfileBottomSheet({super.key});

  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    _loadUserData();
  }

  void _loadUserData() {
    _usernameController.text = PreferencesManager().getString('username') ?? "";
    _emailController.text = PreferencesManager().getString('user_email') ?? "";
  }

  void _saveUserData() async {
    if (_key.currentState?.validate() ?? false) {
      await PreferencesManager().setString(
        'username',
        _usernameController.text,
      );
      await PreferencesManager().setString('user_email', _emailController.text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.r16),
          topRight: Radius.circular(AppSizes.r16),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: AppSizes.w32,
                    height: AppSizes.h4,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(AppSizes.r16),
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.h24),
                Text(
                  'Profile Info',
                  style: TextStyle(
                    fontSize: AppSizes.sp20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSizes.h24),
                CustomTextFormField(
                  hintText: PreferencesManager().getString('username'),
                  controller: _usernameController,
                  title: 'User Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter User Name';
                    }
                  },
                ),
                SizedBox(height: AppSizes.h16),
                CustomTextFormField(
                  hintText: PreferencesManager().getString('user_email'),
                  controller: _emailController,
                  title: 'Email',
                  validator: (value) {
                    RegExp emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSizes.h40),
                CustomElevatedButton(
                  text: 'Save',
                  onPressed: () {
                    _saveUserData();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
