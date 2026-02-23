import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_lms/core/assets_manegar/assets_manegar.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/features/layout/enroled_cources/enroled_cources_screen.dart';
import 'package:school_lms/features/layout/home/home_screen.dart';
import 'package:school_lms/features/layout/profile/profile_screen.dart';

class Mainlayout extends StatefulWidget {
  const Mainlayout({super.key});

  @override
  State<Mainlayout> createState() => _MainlayoutState();
}

class _MainlayoutState extends State<Mainlayout> {
  int currentIndex = 0;
  List<Widget> taps = [
    const HomeScreen(),
    const EnroledCourcesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: taps[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              AssetsManegar.homeIcon,
              width: currentIndex == 0 ?40.w:30.w,
              color: currentIndex == 0 ? Theme.of(context).primaryColor : ColorsManger.gray,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AssetsManegar.barinIcon,
              width: currentIndex == 1 ?40.w:30.w,
              color: currentIndex == 1 ?Theme.of(context).primaryColor : ColorsManger.gray,
            ),
            label: 'Cources',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AssetsManegar.profileIcon,
              width: currentIndex == 2 ?40.w:30.w,
              color: currentIndex == 2 ? Theme.of(context).primaryColor : ColorsManger.gray,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
