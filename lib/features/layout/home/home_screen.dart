import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/features/layout/home/cource_item.dart';
import 'package:school_lms/models/cource_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Text(
                'Welcome, ',
                style: GoogleFonts.plusJakartaSans(
                  color: ColorsManger.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Kassem',
                style: GoogleFonts.plusJakartaSans(
                  color: ColorsManger.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          actions: [
            InkWell(
              child: Icon(
                CupertinoIcons.globe,
                color: ColorsManger.gray,
                size: 26.sp,
              ),
            ),
            SizedBox(width: 10.w),
            InkWell(
              child: Icon(
                Icons.notifications_outlined,
                color: ColorsManger.gray,
                size: 26.sp,
              ),
            ),
            SizedBox(width: 10.w),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Column(
              children: [
                TextField(
                  cursorColor: const Color.fromARGB(255, 122, 122, 122),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: ColorsManger.gray,
                      size: 26.sp,
                    ),
                    hint: Text(
                      'Search Here',
                      style: GoogleFonts.plusJakartaSans(
                        color: Color.fromARGB(255, 198, 198, 198),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    filled: true,
                    fillColor: ColorsManger.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 7.w,
                      vertical: 10.h,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 198, 198, 198),
                        width: 1.w,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 122, 122, 122),
                        width: 1.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    Text(
                      'Cources',
                      style: GoogleFonts.plusJakartaSans(
                        color: ColorsManger.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 11.w,
                    mainAxisSpacing: 5.h,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) => CourceItem(
                    cource: CourceModel.cources[index],
                    // Notify HomeScreen to rebuild when returning from details
                    onReturn: () => setState(() {}),
                  ),
                  itemCount: CourceModel.cources.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
