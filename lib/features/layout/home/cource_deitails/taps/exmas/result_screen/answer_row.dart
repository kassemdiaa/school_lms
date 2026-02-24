import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnswerRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const AnswerRow(
      {super.key, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ',
            style: TextStyle(
                color: color.withOpacity(0.7),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600)),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  color: color, fontSize: 12.sp, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
