import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/core/progress/progress_manager.dart';
import 'package:school_lms/features/layout/home/cource_deitails/taps/exmas/exam_screen.dart';
import 'package:school_lms/models/chapter_model.dart';

class ExamItem extends StatefulWidget {
  const ExamItem({super.key, required this.chapter, required this.courseId});
  final ChapterModel chapter;
  final int courseId;

  @override
  State<ExamItem> createState() => _ExamItemState();
}

class _ExamItemState extends State<ExamItem> {
  bool get _isPassed => ProgressManager.isChapterPassed(
        widget.courseId,
        widget.chapter.id,
      );

  @override
  Widget build(BuildContext context) {
    final passed = _isPassed;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ExamScreen(
              chapter: widget.chapter,
              courseId: widget.courseId,
            ),
          ),
        ).then((_) {
          // Refresh the icon when returning from the exam
          setState(() {});
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: passed
              ? const Color.fromARGB(40, 76, 175, 80)  // light green tint when passed
              : ColorsManger.lightBlue,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: passed ? const Color(0xFF4CAF50) : ColorsManger.gray,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Exam ${widget.chapter.id + 1} : ${widget.chapter.name}',
              style: GoogleFonts.plusJakartaSans(
                color: ColorsManger.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (passed)
              Container(
                width: 28.w,
                height: 28.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
