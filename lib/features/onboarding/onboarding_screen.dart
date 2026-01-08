import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/features/onboarding/controller/onboarding_controller.dart';
import 'package:news_app/features/onboarding/models/onboarding_model.dart';
import 'package:provider/provider.dart';

import '../../core/datasource/local_data/preference_manager.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  _onFinish(BuildContext context) async {
    await PreferencesManager().setBool('onboarding_complete', true);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => OnboardingController(),
      builder: (context, child) {
        final controller = context.read<OnboardingController>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xfff5f5f5),
            actions: [
              Consumer<OnboardingController>(
                builder: (BuildContext context, value, Widget? child) {
                  return value.isLastPage
                      ? SizedBox()
                      : TextButton(
                        onPressed: () {
                          _onFinish(context);
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppSizes.sp16),
                        ),
                      );
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16, vertical: AppSizes.ph30),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: (int index) {
                      Provider.of<OnboardingController>(context, listen: false).onPageChange(index);
                    },
                    itemCount: OnboardingModel.onboardingList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final OnboardingModel model = OnboardingModel.onboardingList[index];
                      return Column(
                        children: [
                          SizedBox(height: AppSizes.ph24),
                          Image.asset(model.image),
                          SizedBox(height: AppSizes.ph24),
                          Text(
                            model.title,
                            style: TextStyle(
                              fontSize: AppSizes.sp20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff4E4B66),
                            ),
                          ),
                          SizedBox(height: AppSizes.ph12),
                          Text(
                            textAlign: TextAlign.center,
                            model.description,
                            style: TextStyle(
                              fontSize: AppSizes.sp16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff6E7191),
                            ),
                          ),
                          SizedBox(height: AppSizes.ph24),
                          Consumer<OnboardingController>(
                            builder: (BuildContext context, value, Widget? child) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  3,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                    child: Container(
                                      width: AppSizes.pw14,
                                      height: AppSizes.ph14,
                                      decoration: BoxDecoration(
                                        color:
                                            value.currentIndex == index
                                                ? Color(0xffC53030)
                                                : Color(0xffD3D3D3),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),

                Consumer<OnboardingController>(
                  builder: (BuildContext context, value, Widget? child) {
                    return CustomElevatedButton(
                      text: value.isLastPage ? 'Get Started' : 'Next',
                      onPressed: () {
                        if (!value.isLastPage) {
                          controller.onNext();
                        } else {
                          _onFinish(context);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
