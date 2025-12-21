import 'package:flutter/cupertino.dart';

class OnboardingController with ChangeNotifier {
  final PageController pageController = PageController();
  int currentIndex = 0;
  bool isLastPage = false;

  void onPageChange(int index) {
    if (index == 2) {
      isLastPage = true;
    } else {
      isLastPage = false;
    }
    currentIndex = index;
    notifyListeners();
  }

  void onNext() {
    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}
