import 'package:expenser_378/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) {
                  return Container(
                    height: 150,
                    padding: EdgeInsets.all(11),
                    child: Column(
                      children: [
                        Text(
                          'Logout?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setInt(AppConstants.PREF_USER_ID_KEY, 0);
                                Navigator.pushReplacementNamed(context, AppRoutes.LOGINPAGE);
                              },
                              child: Text("Yes", style: TextStyle(color: Colors.red, fontSize: 16)),
                            ),
                            SizedBox(width: 11),
                            OutlinedButton(onPressed: () {
                              Navigator.pop(context);
                            }, child: Text("No", style: TextStyle(color: Colors.green, fontSize: 16))),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
        backgroundColor: Colors.green,
      ),
    );
  }
}
