import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/widgets/custom_list_tile.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/profile/controller/profile_controller.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProfileController();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Profile'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ProfileController>(
            builder: (
              BuildContext context,
              ProfileController controller,
              Widget? child,
            ) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              controller.selectedImage == null
                                  ? AssetImage('assets/images/ronaldo.png')
                                  : FileImage(
                                    File(controller.selectedImage!.path),
                                  ),
                          backgroundColor: Colors.transparent,
                          radius: 55.r,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () async {
                              showImageSourceDialog(context);
                            },
                            child: Container(
                              width: 45.w,
                              height: 45.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100).r,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Center(
                    child: Text(
                      PreferencesManager().getString("username") ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: AppSizes.sp16,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Profile Info',
                    style: TextStyle(fontSize: AppSizes.sp14),
                  ),
                  SizedBox(height: 8.h),
                  CustomListTile(
                    title: 'Personal Info',
                    leading: Icon(Icons.person_2),
                    onTap: () {},
                  ),
                  CustomListTile(
                    title: 'Language',
                    leading: Icon(Icons.language_outlined),
                    onTap: () {},
                  ),
                  CustomListTile(
                    title: 'Country',
                    leading: Icon(Icons.flag_outlined),
                    onTap: () {},
                  ),
                  CustomListTile(
                    title: 'Terms & Conditions',
                    leading: Icon(Icons.line_axis_outlined),
                    onTap: () {},
                  ),
                  CustomListTile(
                    title: 'Logout',
                    leading: Icon(Icons.logout),
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    onTap: () async {
                      await PreferencesManager().remove('username');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

void showImageSourceDialog(BuildContext context) {
  final controller = context.read<ProfileController>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(
          'Choose Image Source',
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(fontSize: 20.sp),
        ),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              controller.pickImage(ImageSource.camera);
            },
            child: Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 8.w),
                Text('Camera', style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              controller.pickImage(ImageSource.gallery);
            },
            child: Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(width: 8.w),
                Text('Gallery', style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ),
        ],
      );
    },
  );
}

void _saveImage(XFile file) async {
  final appDir = await getApplicationSupportDirectory();
  final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
  PreferencesManager().setString('user_image', newFile.path);
}
