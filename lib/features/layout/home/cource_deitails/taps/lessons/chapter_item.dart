import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/models/chapter_model.dart';

class ChapterItem extends StatefulWidget {
  ChapterItem({super.key, required this.chapter});
  ChapterModel chapter;

  @override
  State<ChapterItem> createState() => _ChapterItemState();
}

class _ChapterItemState extends State<ChapterItem> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔒 FIXED HEADER (never moves)
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: ColorsManger.lightBlue,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: ColorsManger.gray, width: 1),
              ),
              child: Text(
                'Chapter ${widget.chapter.id} : ${widget.chapter.name}',
                style: GoogleFonts.plusJakartaSans(
                  color: ColorsManger.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // 👇 ONLY THIS PART EXPANDS
          ClipRect(
            child: AnimatedAlign(
              alignment: Alignment.topLeft,
              heightFactor: isExpanded ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManger.lightBlue,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: ColorsManger.gray, width: 1),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          child: Row(
                            children: [
                              Image.asset('assets/circledPlay.png',width: 24.w,),
                              SizedBox(width: 14.w,),
                              Text(
                                'Lorem ipsum dolor sit amet consectetur.',
                                style: GoogleFonts.plusJakartaSans(
                                  color: ColorsManger.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h,),
                        InkWell(
                          child: Row(
                            children: [
                              Image.asset('assets/viewdetails.png',width: 24.w,),
                              SizedBox(width: 14.w,),
                              Text(
                                'Lorem ipsum dolor sit amet consectetur.',
                                style: GoogleFonts.plusJakartaSans(
                                  color: ColorsManger.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
