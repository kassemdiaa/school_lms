import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/l10n/app_localizations.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.school_outlined,
                size: 70.sp,
                color: const Color.fromARGB(255, 198, 198, 198)),
            SizedBox(height: 20.h),
            Text(
              'No enrolled courses yet',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Pass at least one exam chapter to see your progress here.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                color: Colors.black38,
                height: 1.6.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}