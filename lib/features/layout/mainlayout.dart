import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_lms/core/assets_manegar/assets_manegar.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/features/layout/enroled_cources/enroled_cources_screen.dart';
import 'package:school_lms/features/layout/home/home_screen.dart';
import 'package:school_lms/features/layout/notifications/notifications_screen.dart';
import 'package:school_lms/features/layout/profile/profile_screen.dart';

class Mainlayout extends StatefulWidget {
  const Mainlayout({super.key});

  @override
  State<Mainlayout> createState() => _MainlayoutState();
}

class _MainlayoutState extends State<Mainlayout> {
  int currentIndex = 0;

  final List<Widget> taps = [
    const HomeScreen(),
    const EnroledCourcesScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: taps[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // use the theme's background color (defaults to bottomNavigationBarTheme)
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        // let the bar manage icon/text colors via selected/unselectedItemColor
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: ColorsManger.gray,
        items: [
          // ── Home ──────────────────────────────────────────────────────────
          BottomNavigationBarItem(
            label: 'Home',
            icon: ImageIcon(
              AssetImage(AssetsManegar.homeIcon),
              size: currentIndex == 0 ? 30.sp : 26.sp,
            ),
          ),

          // ── Enrolled Courses ──────────────────────────────────────────────
          BottomNavigationBarItem(
            label: 'Courses',
            icon: ImageIcon(
              AssetImage(AssetsManegar.barinIcon),
              size: currentIndex == 1 ? 30.sp : 26.sp,
            ),
          ),

          // ── Notifications ─────────────────────────────────────────────────
          BottomNavigationBarItem(
            label: 'Notifications',
            icon: Icon(
              currentIndex == 2
                  ? Icons.notifications_rounded
                  : Icons.notifications_outlined,
              size: currentIndex == 2 ? 30.sp : 26.sp,
            ),
          ),

          // ── Profile ───────────────────────────────────────────────────────
          BottomNavigationBarItem(
            label: 'Profile',
            icon: ImageIcon(
              AssetImage(AssetsManegar.profileIcon),
              size: currentIndex == 3 ? 30.sp : 26.sp,
            ),
          ),
        ],
      ),
    );
  }
}
