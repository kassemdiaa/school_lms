import 'package:flutter/material.dart';
import 'package:school_lms/core/colors/colors_manger.dart';

abstract class ThemeManger {
  static ThemeData light = ThemeData(
    appBarTheme: AppBarThemeData(backgroundColor: ColorsManger.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: ColorsManger.white),
    scaffoldBackgroundColor: ColorsManger.white,
    primaryColor: ColorsManger.blue,
    primaryColorLight: ColorsManger.black,
    primaryColorDark: ColorsManger.blue,
    secondaryHeaderColor: ColorsManger.lightBlue,
    hoverColor: ColorsManger.white,
    canvasColor: ColorsManger.blue,
    cardColor: ColorsManger.lightBlue
  );
  static ThemeData dark = ThemeData(
    appBarTheme: AppBarThemeData(backgroundColor: ColorsManger.darkPurple),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: ColorsManger.darkPurple),
    scaffoldBackgroundColor: ColorsManger.darkPurple,
    primaryColor: ColorsManger.purple,
    primaryColorLight: ColorsManger.white,
    primaryColorDark: ColorsManger.cyen,
    secondaryHeaderColor: ColorsManger.purple,
    hoverColor: ColorsManger.purple,
    canvasColor: ColorsManger.white,
    cardColor: ColorsManger.lightPurple
  );
}
