import 'package:flutter/material.dart';
import 'package:news_app/features/home/home_screen.dart';
import 'package:news_app/features/onboarding/onboarding_screen.dart';

import '../../core/datasource/local_data/preference_manager.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  void _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 2));

    //check if the user has completed the onboarding process
    final bool onboardingComplete =
        PreferencesManager().getBool('onboarding_complete') ?? false;

    //check if the user is logged in
    final bool isLoggedIn =
        PreferencesManager().getBool('is_logged_in') ?? false;

    if (!mounted) return;
    if (!onboardingComplete) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return OnboardingScreen();
          },
        ),
      );
    } else if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginScreen();
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return HomeScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/splash.png',
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
