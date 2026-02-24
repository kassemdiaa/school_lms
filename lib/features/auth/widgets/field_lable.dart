import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Text(label,
            style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).primaryColorLight)),
      );
}