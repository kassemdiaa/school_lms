import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/assets_manegar/assets_manegar.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/core/routes/routes_manger.dart';
import 'package:school_lms/main.dart'; // ← import markOnboardingSeen

class OnbourdingFour extends StatelessWidget {
  const OnbourdingFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            SvgPicture.asset(AssetsManegar.onbourdingFour, width: 346.w),
            SizedBox(height: 20.h),
            Text(
              'Join a community of learners and',
              style: GoogleFonts.plusJakartaSans(
                color: Theme.of(context).primaryColorLight,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'embark on a learning adventure',
              style: GoogleFonts.plusJakartaSans(
                color: Theme.of(context).primaryColorLight,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                // Mark onboarding as seen — never shows again
                await markOnboardingSeen();
                if (context.mounted) {
                  Navigator.pushNamed(context, RoutesManger.loginOrRegister);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding:
                    EdgeInsets.symmetric(horizontal: 58.w, vertical: 16.h),
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
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
