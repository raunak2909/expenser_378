import 'package:expenser_378/ui/add_expense/add_expense_page.dart';
import 'package:expenser_378/ui/dashboard_page/dashboard_page.dart';
import 'package:expenser_378/ui/login/login_screen.dart';
import 'package:expenser_378/ui/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

import '../../ui/dashboard_page/nav_pages/home/home_page.dart';
import '../../ui/splash/spalsh_page.dart';

class AppRoutes{


  static const String SPLASHPAGE = "/splash";
  static const String DASHBOARDPAGE = "/dashboard";
  static const String LOGINPAGE = "/login";
  static const String SIGNUPPAGE = "/signup";
  static const String ADDEXPENSEPAGE = "/add-expense";
  static const String STATSPAGE = "/stats";

  static Map<String, Widget Function(BuildContext)> routes = {
    SPLASHPAGE: (context) => SplashScreen(),
    LOGINPAGE: (context) => LoginScreen(),
    SIGNUPPAGE: (context) => SignUpScreen(),
    DASHBOARDPAGE: (context) => DashBoardPage(),
    ADDEXPENSEPAGE: (context) => AddExpensePage(),
  };

}