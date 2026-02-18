import 'package:flutter/material.dart';
import 'package:school_lms/core/routes/routes_manger.dart';


void main() {
  runApp(const SchoolLms());
}

class SchoolLms extends StatelessWidget {
  const SchoolLms({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesManger.getRoute,
      initialRoute: RoutesManger.onbourdingOne,
      locale: Locale('en'),
      theme: ThemeData(),
      darkTheme: ThemeData(),
      themeMode: ThemeMode.light,
    );
  }
}