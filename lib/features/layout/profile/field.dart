import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Field extends StatelessWidget {
  const Field(
      {required this.ctrl,
      required this.label,
      this.maxLines = 1,
      this.hint});
  final TextEditingController ctrl;
  final String label;
  final int maxLines;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black54)),
        SizedBox(height: 6.h),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp, color: Colors.black87),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp, color: Colors.black26),
            filled: true,
            fillColor: const Color(0xFFF2F4F8),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                  color: Color(0xFF002F96), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
