import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NavButton extends StatelessWidget {
  const NavButton({super.key, 
    required this.icon,
    required this.label,
    required this.onTap,
    this.isRight = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isRight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          if (!isRight)
            Icon(icon,
                color: Theme.of(context).primaryColorLight ,
                size: 20.sp),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          if (isRight)
            Icon(icon,
                color: Theme.of(context).primaryColorLight,
                size: 20.sp),
        ],
      ),
    );
  }
}