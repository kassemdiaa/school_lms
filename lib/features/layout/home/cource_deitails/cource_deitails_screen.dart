import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/features/layout/home/cource_deitails/taps/lessons/lessons_tap.dart';
import 'package:school_lms/features/layout/home/cource_deitails/taps/overview/overview_tap.dart';
import 'package:school_lms/features/layout/home/cource_deitails/taps/exmas/exams_tap.dart';
import 'package:school_lms/models/cource_model.dart';

class CourceDeitailsScreen extends StatefulWidget {
  const CourceDeitailsScreen({super.key});

  @override
  State<CourceDeitailsScreen> createState() => _CourceDeitailsScreenState();
}

class _CourceDeitailsScreenState extends State<CourceDeitailsScreen> {
  // keep track of the currently selected tab –
  // defining it here ensures it survives rebuilds
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final cource =
        ModalRoute.of(context)?.settings.arguments as CourceModel? ??
        CourceModel.cources[1];

    List<Widget> taps =[
      OverviewTap(cource: cource,),
      LessonsTap(cource: cource,),
      ExamsTap(cource: cource,)
    ];
    return Scaffold(
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
                Expanded(
                  child: InkWell(
                    onTap: () {
                      selectedIndex = 0;
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                  
                      decoration: BoxDecoration(
                        color: selectedIndex == 0 ? ColorsManger.blue : null,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(14.r),
                        ),
                      ),
                      child: Text(
                        'Overview',
                        style: GoogleFonts.plusJakartaSans(
                          color: selectedIndex == 0
                              ? ColorsManger.white
                              : ColorsManger.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      selectedIndex = 1;
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                      
                      decoration: BoxDecoration(color: selectedIndex == 1 ? ColorsManger.blue : null,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.r),bottomRight: Radius.circular(10.r))),
                      child: Text(
                        'Lessons',
                        style: GoogleFonts.plusJakartaSans(
                          color: selectedIndex == 1
                              ? ColorsManger.white
                              : ColorsManger.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      selectedIndex = 2;
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                      
                      decoration: BoxDecoration(color: selectedIndex == 2 ? ColorsManger.blue : null,borderRadius: BorderRadius.only(bottomRight: Radius.circular(14.r))),
                      child: Text(
                        'Exams',
                        style: GoogleFonts.plusJakartaSans(
                          color: selectedIndex == 2
                              ? ColorsManger.white
                              : ColorsManger.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //Container(width: double.infinity,color: ColorsManger.blue,height: 2,),
            taps[selectedIndex]
          ],
        ),
      ),
    );
  }
}
