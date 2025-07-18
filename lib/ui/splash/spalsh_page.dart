import 'dart:async';

import 'package:expenser_378/utils/app_constants.dart';
import 'package:expenser_378/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      navigateTo();
    });
  }

  void navigateTo() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int uid = prefs.getInt(AppConstants.PREF_USER_ID_KEY) ?? 0;

    String navigateToName = AppRoutes.LOGINPAGE;

    if(uid>0){
      navigateToName = AppRoutes.DASHBOARDPAGE;
    }

    Navigator.pushReplacementNamed(context, navigateToName);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xFFF2F2F2),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/splash_logo2.png",
              width: 500,
            ),
            Text(
              "TrackMint",
              style: TextStyle(
                fontSize: 40,
                //color: Color(0xFF333333),
              ),
            )
          ],
        ));
  }
}
