import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/core/routes/routes_manger.dart';

class OnbourdingTwo extends StatelessWidget {
  const OnbourdingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/onbourdingtwo.svg', width: 346.w),
            SizedBox(height: 20.h,),
            Text(
              'Begin your learning journey and',
              style: GoogleFonts.plusJakartaSans(
                color: ColorsManger.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h,),
            Text(
              'unlock a world of knowledge',
              style: GoogleFonts.plusJakartaSans(
                color: ColorsManger.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 91.h,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesManger.onbourdingThree);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManger.blue,
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
          ],
        ),
      ),
    );
  }
}