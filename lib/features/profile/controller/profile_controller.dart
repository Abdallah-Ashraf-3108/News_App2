import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';

class ProfileController extends ChangeNotifier with SafeNotifyMixin {
  // this is a constructor
  ProfileController() {
    getUserData();
  }

  XFile? selectedImage;
  String? userName;
  Country? selectedCountry;
  String? countryName;
  String? countryCode;

  void pickImage(ImageSource source) async {
    final selectedImage = await ImagePicker().pickImage(source: source);
    if (selectedImage != null) {
      this.selectedImage = selectedImage;
      await _saveImage(selectedImage);
      safeNotify();
    }
  }

  void getUserData() {
    userName = PreferencesManager().getString('username') ?? "";
    countryName = PreferencesManager().getString('country_name');
    countryCode = PreferencesManager().getString('country_code');

    final imagePath = PreferencesManager().getString('user_image');

    if (imagePath != null &&
        imagePath.isNotEmpty &&
        File(imagePath).existsSync()) {
      selectedImage = XFile(imagePath);
    } else {
      selectedImage = null;
    }

    safeNotify();

    safeNotify();
  }

  void saveCountry(Country selectedCountry) {
    PreferencesManager().setString('country_name', selectedCountry.name);
    PreferencesManager().setString('country_code', selectedCountry.countryCode);

    countryName = selectedCountry.name;
    countryCode = selectedCountry.countryCode;

    safeNotify();
  }

  Future<void> _saveImage(XFile file) async {
    final appDir = await getApplicationSupportDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    PreferencesManager().setString('user_image', newFile.path);
  }
}
