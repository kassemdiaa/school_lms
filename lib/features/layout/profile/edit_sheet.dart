import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/features/layout/profile/field.dart';
import 'package:school_lms/l10n/app_localizations.dart';

class EditSheet extends StatelessWidget {
  const EditSheet({
    required this.l10n,
    required this.nameCtrl,
    required this.tagCtrl,
    required this.aboutCtrl,
    required this.skillCtrl,
    required this.onSave,
  });
  final AppLocalizations l10n;
  final TextEditingController nameCtrl;
  final TextEditingController tagCtrl;
  final TextEditingController aboutCtrl;
  final TextEditingController skillCtrl;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 30.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(4.r)),
              ),
            ),
            SizedBox(height: 20.h),
            Text(l10n.profile,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                )),
            SizedBox(height: 20.h),
            Field(ctrl: nameCtrl,  label: l10n.name),
            SizedBox(height: 14.h),
            Field(ctrl: tagCtrl,   label: l10n.tagline),
            SizedBox(height: 14.h),
            Field(ctrl: aboutCtrl, label: l10n.aboutme, maxLines: 4),
            SizedBox(height: 14.h),
            Field(
              ctrl: skillCtrl,
              label: l10n.myskills,
              hint: 'e.g. Flutter, Dart, UI/UX',
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r)),
                  elevation: 0,
                ),
                child: Text(l10n.savechanges,
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700, fontSize: 14.sp)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}