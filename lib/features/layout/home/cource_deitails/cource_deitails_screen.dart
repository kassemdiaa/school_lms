import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/features/layout/home/cource_deitails/taps/lessons/lessons_tap.dart';
import 'package:school_lms/features/layout/home/cource_deitails/taps/overview/overview_tap.dart';
import 'package:school_lms/features/layout/home/cource_deitails/taps/exmas/exams_tap.dart';
import 'package:school_lms/models/cource_model.dart';
import 'package:school_lms/l10n/app_localizations.dart';

class CourceDeitailsScreen extends StatefulWidget {
  const CourceDeitailsScreen({super.key});
  @override
  State<CourceDeitailsScreen> createState() => _CourceDeitailsScreenState();
}

class _CourceDeitailsScreenState extends State<CourceDeitailsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cource =
        ModalRoute.of(context)?.settings.arguments as CourceModel? ??
        CourceModel.getCources(context)[0];

    final List<Widget> taps = [
      OverviewTap(cource: cource),
      LessonsTap(cource: cource),
      ExamsTap(cource: cource),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              width: 390.w,
              height: 210.h,
              child: Image.asset(cource.coverPath, fit: BoxFit.cover),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Overview tab
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => selectedIndex = 0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: selectedIndex == 0 ? Theme.of(context).primaryColor : null,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(14.r)),
                      ),
                      child: Text(
                        l10n.overview,
                        style: GoogleFonts.plusJakartaSans(
                          color: selectedIndex == 0
                              ? ColorsManger.white
                              : Theme.of(context).canvasColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                // Lessons tab
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => selectedIndex = 1),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: selectedIndex == 1 ? Theme.of(context).primaryColor : null,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.r),
                          bottomRight: Radius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        l10n.lessons,
                        style: GoogleFonts.plusJakartaSans(
                          color: selectedIndex == 1
                              ? ColorsManger.white
                              : Theme.of(context).canvasColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                // Exams tab
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => selectedIndex = 2),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: selectedIndex == 2 ?Theme.of(context).primaryColor : null,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(14.r)),
                      ),
                      child: Text(
                        l10n.exams,
                        style: GoogleFonts.plusJakartaSans(
                          color: selectedIndex == 2
                              ? ColorsManger.white
                              : Theme.of(context).canvasColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            taps[selectedIndex],
          ],
        ),
      ),
    );
  }
}
