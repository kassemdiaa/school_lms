import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_lms/features/layout/home/cource_deitails/taps/lessons/chapter_item.dart';
import 'package:school_lms/models/cource_model.dart';

class LessonsTap extends StatelessWidget {
  LessonsTap({super.key, required this.cource});
  CourceModel cource;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) => ChapterItem(chapter: cource.chapters[index]),
        separatorBuilder: (context, index) => SizedBox(height: 10.h,),
        itemCount: cource.chapters.length,
      ),
    );
  }
}
