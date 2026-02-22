import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/models/chapter_model.dart';
import 'package:school_lms/features/layout/home/cource_deitails/taps/lessons/video_player_screen.dart';
import 'package:school_lms/features/layout/home/cource_deitails/taps/lessons/pdf_viewer_screen.dart';

class ChapterItem extends StatefulWidget {
  const ChapterItem({super.key, required this.chapter});
  final ChapterModel chapter;

  @override
  State<ChapterItem> createState() => _ChapterItemState();
}

class _ChapterItemState extends State<ChapterItem> {
  bool isExpanded = false;

  void _openPdf() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PdfViewerScreen(
          pdfPath: widget.chapter.docPath, // e.g. 'assets/docs/chapter1.pdf'
          title: 'Chapter ${widget.chapter.id + 1} : ${widget.chapter.name}',
        ),
      ),
    );
  }

  void _openVideo() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VideoPlayerScreen(
          videoPath: widget.chapter.videoPath, // e.g. 'assets/videos/chapter1.mp4'
          title: 'Chapter ${widget.chapter.id + 1} : ${widget.chapter.name}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header (tap to expand) ────────────────────────────────────────
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: ColorsManger.lightBlue,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: ColorsManger.gray, width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Chapter ${widget.chapter.id + 1} : ${widget.chapter.name}',
                      style: GoogleFonts.plusJakartaSans(
                        color: ColorsManger.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(Icons.keyboard_arrow_down_rounded,
                        color: ColorsManger.blue, size: 20.sp),
                  ),
                ],
              ),
            ),
          ),

          // ── Expandable content ────────────────────────────────────────────
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
                        horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: ColorsManger.lightBlue,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: ColorsManger.gray, width: 1),
                    ),
                    child: Column(
                      children: [
                        // ── Video row ─────────────────────────────────────
                        InkWell(
                          borderRadius: BorderRadius.circular(8.r),
                          onTap: _openVideo, // ← plays the video
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/circledPlay.png',
                                  width: 24.w,
                                ),
                                SizedBox(width: 14.w),
                                Expanded(
                                  child: Text(
                                    'Watch Lesson Video',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: ColorsManger.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Icon(Icons.chevron_right_rounded,
                                    color: ColorsManger.blue, size: 18.sp),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),

                        // ── Docs row ─────────────────────────────────────
                        InkWell(
                          borderRadius: BorderRadius.circular(8.r),
                          onTap: _openPdf, // ← opens the PDF viewer

                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/viewdetails.png',
                                  width: 24.w,
                                ),
                                SizedBox(width: 14.w),
                                Expanded(
                                  child: Text(
                                    'View Lesson Details',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: ColorsManger.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Icon(Icons.chevron_right_rounded,
                                    color: ColorsManger.blue, size: 18.sp),
                              ],
                            ),
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
