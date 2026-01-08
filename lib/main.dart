import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/features/splash/splash_screen.dart';

import 'core/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await PreferencesManager().init();
  PreferencesManager().clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 832),
      minTextAdapt: true,
      builder: (context, _) {
        return MaterialApp(
          title: 'News App',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: SplashScreen(),
        );
      },
    );
  }
}
