import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/progress/progress_manager.dart';
import 'package:school_lms/features/layout/enroled_cources/empty_state.dart';
import 'package:school_lms/features/layout/enroled_cources/enrolled_cources_card.dart';
import 'package:school_lms/models/cource_model.dart';
import 'package:school_lms/l10n/app_localizations.dart';

class EnroledCourcesScreen extends StatefulWidget {
  const EnroledCourcesScreen({super.key});
  @override
  State<EnroledCourcesScreen> createState() => _EnroledCourcesScreenState();
}

class _EnroledCourcesScreenState extends State<EnroledCourcesScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final allCources = CourceModel.getCources(context);
    final enrolled = allCources
        .where((c) => ProgressManager.passedCount(c.id) > 0)
        .toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          title: Text(
            l10n.contiuecources,
            style: GoogleFonts.plusJakartaSans(
              color: Theme.of(context).primaryColorLight,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: enrolled.isEmpty
            ? EmptyState(l10n: l10n)
            : ListView.separated(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                itemCount: enrolled.length,
                separatorBuilder: (_, __) => SizedBox(height: 14.h),
                itemBuilder: (context, index) {
                  final course = enrolled[index];
                  return EnrolledCourseCard(
                    course: course,
                    onReturn: () => setState(() {}),
                  );
                },
              ),
      ),
    );
  }
}