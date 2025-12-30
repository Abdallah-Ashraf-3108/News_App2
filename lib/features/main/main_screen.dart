import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../bookmark/bookmark_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../search/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    BookmarkScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 0
                    ? const Color(0xffC53030)
                    : const Color(0xff363636),
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 1
                    ? const Color(0xffC53030)
                    : const Color(0xff363636),
                BlendMode.srcIn,
              ),
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/bookmark.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 2
                    ? const Color(0xffC53030)
                    : const Color(0xff363636),
                BlendMode.srcIn,
              ),
            ),
            label: "Bookmark",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/profile.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 3
                    ? const Color(0xffC53030)
                    : const Color(0xff363636),
                BlendMode.srcIn,
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }
}
