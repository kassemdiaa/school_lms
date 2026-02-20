import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/core/routes/routes_manger.dart';
import 'package:school_lms/features/layout/home/cource_deitails/cource_deitails_screen.dart';
import 'package:school_lms/models/cource_model.dart';

class CourceItem extends StatelessWidget {
  const CourceItem({super.key, required this.cource});
  final CourceModel cource;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutesManger.courceDietails,
          arguments: cource
        );
      },
      child: Column(
        children: [
          Container(
            width: 174.w,
            height: 174.h,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(10.r),
              child: Image.asset(cource.imagePath, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cource.name,
                style: GoogleFonts.plusJakartaSans(
                  color: ColorsManger.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Image.asset('assets/rate.png'),
            ],
          ),
          Row(
            children: [
              Text(
                'By ',
                style: GoogleFonts.plusJakartaSans(
                  color: ColorsManger.gray,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                cource.instractorName,
                style: GoogleFonts.plusJakartaSans(
                  color: ColorsManger.gray,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '50% Done',
                style: GoogleFonts.plusJakartaSans(
                  color: ColorsManger.gray,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(child: Container(color: ColorsManger.blue, height: 4)),
              Expanded(child: Container(color: ColorsManger.gray, height: 4)),
            ],
          ),
        ],
      ),
    );
  }
}
