import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/core/routes/routes_manger.dart';

class LoginOrRegisterScreen extends StatelessWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/loginorregister.svg', width: 346.w),
            SizedBox(height: 20.h,),
            Text(
              'Join Cybex IT Group to Kick Start ',
              style: GoogleFonts.plusJakartaSans(
                color: ColorsManger.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h,),
            Text(
              'Your Lesson',
              style: GoogleFonts.plusJakartaSans(
                color: ColorsManger.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 91.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesManger.login);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManger.blue,
                    padding: EdgeInsets.symmetric(horizontal: 48.w,vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.plusJakartaSans(
                      color: ColorsManger.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 8.w,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesManger.register);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManger.white,
                    padding: EdgeInsets.symmetric(horizontal: 48.w,vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorsManger.blue,width: 1,),
                      borderRadius: BorderRadiusGeometry.circular(10.r)
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.plusJakartaSans(
                      color: ColorsManger.blue,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}