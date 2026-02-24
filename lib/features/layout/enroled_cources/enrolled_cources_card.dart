import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/core/progress/progress_manager.dart';
import 'package:school_lms/core/routes/routes_manger.dart';
import 'package:school_lms/models/cource_model.dart';

class EnrolledCourseCard extends StatelessWidget {
  const EnrolledCourseCard(
      {required this.course, required this.onReturn});
  final CourceModel course;
  final VoidCallback onReturn;

  @override
  Widget build(BuildContext context) {
    final totalChapters  = course.chapters.length;
    final passedChapters = ProgressManager.passedCount(course.id);
    final percent = totalChapters > 0
        ? (passedChapters / totalChapters * 100).round()
        : 0;

    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutesManger.courceDietails,
          arguments: course,
        ).then((_) => onReturn());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).hoverColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Thumbnail ──────────────────────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                bottomLeft: Radius.circular(16.r),
              ),
              child: Image.asset(
                course.imagePath,
                width: 100.w,
                height: 110.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 14.w),

            // ── Info ───────────────────────────────────────────────────────
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColorLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'By ${course.instractorName}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        color: ColorsManger.gray,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: LinearProgressIndicator(
                        value: totalChapters > 0
                            ? passedChapters / totalChapters
                            : 0,
                        minHeight: 6,
                        backgroundColor: ColorsManger.gray.withOpacity(0.25),
                        valueColor: AlwaysStoppedAnimation(Theme.of(context).canvasColor),
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // Progress text + chapters badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$percent% Done',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10.sp,
                            color: Theme.of(context).canvasColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: ColorsManger.lightBlue,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            '$passedChapters / $totalChapters chapters',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 9.sp,
                              color: Theme.of(context).canvasColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.w),

            // ── Arrow ──────────────────────────────────────────────────────
            Icon(Icons.chevron_right_rounded,
                color: ColorsManger.blue, size: 22.sp),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }
}
