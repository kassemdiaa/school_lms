import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_lms/config/theme/dark_theme.dart';
import 'package:school_lms/core/routes/routes_manger.dart';


void main() {
  runApp(const SchoolLms());
}

class SchoolLms extends StatelessWidget {
  const SchoolLms({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManger.getRoute,
        initialRoute: RoutesManger.mainLayout,
        locale: Locale('en'),
        theme: ThemeManger.light,
        darkTheme: ThemeManger.dark,
        themeMode: ThemeMode.light,
      ),
    );
  }
}