import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Notifications',
            style: GoogleFonts.plusJakartaSans(
              color: Theme.of(context).primaryColorLight,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.notifications_off_outlined,
                size: 70.sp,
                color: const Color.fromARGB(255, 198, 198, 198),
              ),
              SizedBox(height: 16.h),
              Text(
                'No notifications yet',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'You\'re all caught up!\nWe\'ll notify you when something arrives.',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  color: Colors.black38,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
