import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/core/routes/routes_manger.dart';
import 'package:school_lms/features/layout/home/cource_deitails/taps/exmas/exam_screen.dart';
import 'package:school_lms/models/chapter_model.dart';

class ExamItem extends StatelessWidget {
  ExamItem({super.key, required this.chapter});
  ChapterModel chapter;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ExamScreen(chapter: chapter),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorsManger.lightBlue,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: ColorsManger.gray, width: 1),
        ),
        child: Text(
          'Exam ${chapter.id} : ${chapter.name}',
          style: GoogleFonts.plusJakartaSans(
            color: ColorsManger.black,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
