import 'package:flutter/material.dart';

import '../../ui/splash/spalsh_page.dart';

class AppRoutes{


  static const String SPLASHPAGE = "/splash";
  static const String HOMEPAGE = "/home";
  static const String LOGINPAGE = "/login";
  static const String SIGNUPPAGE = "/signup";
  static const String ADDEXPENSEPAGE = "/add-expense";
  static const String STATSPAGE = "/stats";

  static Map<String, Widget Function(BuildContext)> routes = {
    SPLASHPAGE: (context) => SplashPage(),
  };

}