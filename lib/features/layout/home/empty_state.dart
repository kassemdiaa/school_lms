import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.query});
  final String query;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.search,
              size: 54.sp,
              color: const Color.fromARGB(255, 198, 198, 198)),
          SizedBox(height: 16.h),
          Text(
            'No courses found for\n"$query"',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              color: const Color.fromARGB(255, 160, 160, 160),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              height: 1.5.h,
            ),
          ),
        ],
      ),
    );
  }
}
