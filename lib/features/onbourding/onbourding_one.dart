import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/assets_manegar/assets_manegar.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/core/routes/routes_manger.dart';

class OnbourdingOne extends StatelessWidget {
  const OnbourdingOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SizedBox(height: 30.h,),
            SvgPicture.asset(AssetsManegar.onbourdingOne, width: 346.w),
            SizedBox(height: 20.h,),
            Text(
              'Welcome to Cybex IT Group',
              style: GoogleFonts.plusJakartaSans(
                color: Theme.of(context).primaryColorLight,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h,),
            Text(
              'where learning meets innovation!',
              style: GoogleFonts.plusJakartaSans(
                color: Theme.of(context).primaryColorLight,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesManger.onbourdingTwo);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 58.w,vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10.r),
                ),
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.plusJakartaSans(
                  color: ColorsManger.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 40.h,)
          ],
        ),
      ),
    );
  }
}
