import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_lms/features/layout/home/cource_deitails/taps/exmas/exam_item.dart';
import 'package:school_lms/models/cource_model.dart';

class ExamsTap extends StatelessWidget {
  ExamsTap({super.key, required this.cource});
  final CourceModel cource;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) => ExamItem(
          chapter: cource.chapters[index],
          courseId: cource.id, // ← pass the course id down
        ),
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
        itemCount: cource.chapters.length,
      ),
    );
  }
}
