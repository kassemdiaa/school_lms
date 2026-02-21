import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/models/cource_model.dart';

class OverviewTap extends StatelessWidget {
  OverviewTap({super.key, required this.cource});
  CourceModel cource;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cource.name,
            style: GoogleFonts.plusJakartaSans(
              color: ColorsManger.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Text(
                'By ',
                style: GoogleFonts.plusJakartaSans(
                  color: ColorsManger.gray,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                cource.instractorName,
                style: GoogleFonts.plusJakartaSans(
                  color: ColorsManger.gray,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h,),
          Text(
            cource.description,
            style: GoogleFonts.plusJakartaSans(
              color: ColorsManger.gray,
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 30
          .h,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
            decoration: BoxDecoration(color: ColorsManger.lightBlue,borderRadius: BorderRadius.circular(20.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/bookicon.png', width: 24.w),
                        SizedBox(width: 8.w,),
                        Text(
                          '80+ Lectures',
                          style: GoogleFonts.plusJakartaSans(
                            color: ColorsManger.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h,),
                    Row(
                      children: [
                        Image.asset('assets/clockicon.png', width: 24.w),
                        SizedBox(width: 8.w,),
                        Text(
                          '8 Weeks',
                          style: GoogleFonts.plusJakartaSans(
                            color: ColorsManger.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 40.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/certificateicon.png', width: 24.w),
                        SizedBox(width: 8.w,),
                        Text(
                          'Certificate',
                          style: GoogleFonts.plusJakartaSans(
                            color: ColorsManger.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h,),
                    Row(
                      children: [
                        Image.asset('assets/offoricon.png', width: 24.w),
                        SizedBox(width: 8.w,),
                        Text(
                          '10% Off',
                          style: GoogleFonts.plusJakartaSans(
                            color: ColorsManger.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
