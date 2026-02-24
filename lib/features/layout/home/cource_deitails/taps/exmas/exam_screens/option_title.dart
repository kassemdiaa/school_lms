import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionTile extends StatelessWidget {
  final String label;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  const OptionTile(
      {super.key, required this.label,
      required this.text,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).cardColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 34.w,
              height: 34.h,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white54,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.sp,
                    )),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(text,
                  style: TextStyle(
                    color: isSelected
                        ? Theme.of(context).canvasColor
                        : Theme.of(context).primaryColorLight,
                    fontSize: 15.sp,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  )),
            ),
            if (isSelected)
                  Icon(Icons.check_circle_rounded,
                  color: Color.fromARGB(255, 0, 47, 150), size: 20.r),
          ],
        ),
      ),
    );
  }
}
