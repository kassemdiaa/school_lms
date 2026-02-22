import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/core/progress/progress_manager.dart';
import 'package:school_lms/core/routes/routes_manger.dart';
import 'package:school_lms/models/cource_model.dart';

class CourceItem extends StatefulWidget {
  const CourceItem({super.key, required this.cource, required this.onReturn});
  final CourceModel cource;
  final VoidCallback onReturn; // ← tells HomeScreen to rebuild the grid

  @override
  State<CourceItem> createState() => _CourceItemState();
}

class _CourceItemState extends State<CourceItem> {
  @override
  Widget build(BuildContext context) {
    final totalChapters = widget.cource.chapters.length;
    final passedChapters = ProgressManager.passedCount(widget.cource.id);
    final progressPercent = totalChapters > 0
        ? (passedChapters / totalChapters * 100).round()
        : 0;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutesManger.courceDietails,
          arguments: widget.cource,
        ).then((_) {
          // Rebuild this item AND tell HomeScreen to rebuild all items
          setState(() {});
          widget.onReturn();
        });
      },
      child: Column(
        children: [
          SizedBox(
            width: 174.w,
            height: 174.h,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(10.r),
              child: Image.asset(widget.cource.imagePath, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.cource.name,
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
                widget.cource.instractorName,
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
                '$progressPercent% Done',
                style: GoogleFonts.plusJakartaSans(
                  color: ColorsManger.gray,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          // Progress bar: blue = passed, gray = remaining
          Row(
            children: [
              if (passedChapters > 0)
                Expanded(
                  flex: passedChapters,
                  child: Container(color: ColorsManger.blue, height: 4),
                ),
              if (passedChapters < totalChapters)
                Expanded(
                  flex: totalChapters - passedChapters,
                  child: Container(color: ColorsManger.gray, height: 4),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
