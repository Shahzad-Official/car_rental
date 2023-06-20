import 'package:car_rental/views/home/main_screens/home_page.dart';
import 'package:car_rental/views/home/main_screens/profile_page.dart';
import 'package:car_rental/views/home/main_screens/saved_page.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final PageController _pageController;
  int selectedIndex = 0;

  @override
  void initState() {
    _pageController = PageController(
      keepPage: false,
    );

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int currentIndex = 0;
  List<Widget> get allPages => [
        HomePage(),
        const SavedPage(),
        const ProfilePage(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: allPages,
        ),
      ),
      extendBody: true,
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
        currentIndex: selectedIndex,
        items: [
          SalomonBottomBarItem(
            title: AppText(
              text: "Home",
              color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
            ),
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              height: 30,
              width: 30,
              // ignore: deprecated_member_use
              color: selectedIndex == 0 ? Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color : Colors.grey,
            ),
          ),
          SalomonBottomBarItem(
            title: AppText(
              text: "Saved",
              color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
            ),
            icon: SvgPicture.asset(
              "assets/icons/saved.svg",
              height: 30,
              width: 30,
              // ignore: deprecated_member_use
              color: selectedIndex == 1 ? Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color : Colors.grey,
            ),
          ),
          SalomonBottomBarItem(
            title: AppText(
              text: "Profile",
              color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
            ),
            icon: SvgPicture.asset(
              "assets/icons/user.svg", height: 30,
              width: 30,
              // ignore: deprecated_member_use
              color: selectedIndex == 2 ? Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color : Colors.grey,
            ),
          ),
        ],
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
          _pageController.animateToPage(
            value,
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 100),
          );
        },
      ),
    );
  }
}
