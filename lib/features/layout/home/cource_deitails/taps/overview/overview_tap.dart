import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/assets_manegar/assets_manegar.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/models/cource_model.dart';

class OverviewTap extends StatelessWidget {
  const OverviewTap({super.key, required this.cource});
  final CourceModel cource;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cource.name,
            style: GoogleFonts.plusJakartaSans(
              color: Theme.of(context).primaryColorLight,
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
          SizedBox(height: 18.h),
          Text(
            cource.description,
            style: GoogleFonts.plusJakartaSans(
              color: ColorsManger.gray,
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 30.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AssetsManegar.bookIcon,
                          width: 24.w,
                          color: Theme.of(context).canvasColor,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '80+ Lectures',
                          style: GoogleFonts.plusJakartaSans(
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Image.asset(
                          AssetsManegar.clockIcon,
                          width: 24.w,
                          color: Theme.of(context).canvasColor,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '8 Weeks',
                          style: GoogleFonts.plusJakartaSans(
                            color: Theme.of(context).primaryColorLight,
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
                        Image.asset(
                          AssetsManegar.certificateIcon,
                          width: 24.w,
                          color: Theme.of(context).canvasColor,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Certificate',
                          style: GoogleFonts.plusJakartaSans(
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Image.asset(
                          AssetsManegar.offarIcon,
                          width: 24.w,
                          color: Theme.of(context).canvasColor,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '10% Off',
                          style: GoogleFonts.plusJakartaSans(
                            color: Theme.of(context).primaryColorLight,
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
