import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:car_rental/views/home/main_screens/home_page.dart';
import 'package:car_rental/views/home/main_screens/profile_page.dart';
import 'package:car_rental/views/home/main_screens/saved_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/brand_services.dart';
import '../../services/car_services.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final PageController _pageController;

  final CarServices _carServices = CarServices();
  final BrandServices _brandServices = BrandServices();
  bool isLoading = false;
  getData() async {
    setState(() {
      isLoading = true;
    });

    await _carServices.getAllCars();
    await _brandServices.getAllBrands();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _pageController = PageController(
      keepPage: false,
    );
    getData();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int currentIndex = 0;
  List<Widget> get allPages => [
        HomePage(
          brandData: _brandServices.brandModel,
          carData: _carServices.carModel,
          isLoading: isLoading,
        ),
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
      bottomNavigationBar: AnimatedNotchBottomBar(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
        notchColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
        pageController: _pageController,
        itemLabelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        bottomBarItems: [
          BottomBarItem(
            itemLabel: "Home",
            inActiveItem: SvgPicture.asset(
              "assets/icons/home.svg",
              // ignore: deprecated_member_use
              color: Colors.grey,
            ),
            activeItem: SvgPicture.asset(
              "assets/icons/home.svg",
              // ignore: deprecated_member_use
              color: Theme.of(context)
                  .bottomNavigationBarTheme
                  .selectedIconTheme!
                  .color,
            ),
          ),
          BottomBarItem(
            itemLabel: "Saved",
            inActiveItem: SvgPicture.asset(
              "assets/icons/saved.svg",
              // ignore: deprecated_member_use
              color: Colors.grey,
            ),
            activeItem: SvgPicture.asset(
              "assets/icons/saved.svg",
              // ignore: deprecated_member_use
              color: Theme.of(context)
                  .bottomNavigationBarTheme
                  .selectedIconTheme!
                  .color,
            ),
          ),
          BottomBarItem(
            itemLabel: "Profile",
            inActiveItem: SvgPicture.asset(
              "assets/icons/user.svg",
              // ignore: deprecated_member_use
              color: Colors.grey,
            ),
            activeItem: SvgPicture.asset(
              "assets/icons/user.svg",
              // ignore: deprecated_member_use
              color: Theme.of(context)
                  .bottomNavigationBarTheme
                  .selectedIconTheme!
                  .color,
            ),
          ),
        ],
        onTap: (value) {
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
