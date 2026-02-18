import 'package:flutter/cupertino.dart';
import 'package:school_lms/features/auth/login/login_screen.dart';
import 'package:school_lms/features/auth/login_or_register/login_or_register_screen.dart';
import 'package:school_lms/features/auth/register/register_screen.dart';
import 'package:school_lms/features/layout/cources/cource_dietails/cource_dietails.dart';
import 'package:school_lms/features/layout/mainlayout.dart';
import 'package:school_lms/features/onbourding/onbourding_four.dart';
import 'package:school_lms/features/onbourding/onbourding_one.dart';
import 'package:school_lms/features/onbourding/onbourding_three.dart';
import 'package:school_lms/features/onbourding/onbourding_two.dart';

class RoutesManger {
  static const String onbourdingOne = '/onbourdingone';
  static const String onbourdingTwo = '/onbourdingtwo';
  static const String onbourdingThree = '/onbourdingthree';
  static const String onbourdingFour= '/onbourdingfour';
  static const String register = '/register';
  static const String login = '/login';
  static const String loginOrRegister = '/loginorregister';
  static const String mainLayout = '/mainlayout';
  static const String courceDietails = '/courcedietails';

  static Route? getRoute(RouteSettings settings){
    switch (settings.name){
      case onbourdingOne :
        return CupertinoPageRoute(builder: (context) => OnbourdingOne());
      case onbourdingTwo :
        return CupertinoPageRoute(builder: (context) => OnbourdingTwo());
      case onbourdingThree :
        return CupertinoPageRoute(builder: (context) => OnbourdingThree());
      case onbourdingFour :
        return CupertinoPageRoute(builder: (context) => OnbourdingFour());
      case register :
        return CupertinoPageRoute(builder: (context) => RegisterScreen());
      case login :
        return CupertinoPageRoute(builder: (context) => LoginScreen());
      case loginOrRegister :
        return CupertinoPageRoute(builder: (context) => LoginOrRegisterScreen());
      case mainLayout :
        return CupertinoPageRoute(builder: (context) => Mainlayout());
      case courceDietails :
        return CupertinoPageRoute(builder: (context) => CourceDietails());
    }
  }
}