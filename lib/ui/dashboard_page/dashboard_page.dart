import 'package:flutter/material.dart';

import '../add_expense/add_expense_page.dart';
import 'nav_pages/home/home_page.dart';
import 'nav_pages/stats/stats_page.dart';

class DashBoardPage extends StatefulWidget {

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int selectedPageIndex = 0;

  List<Widget> navPages = [
    HomePage(),
    StatisticsPage(),
    AddExpensePage(),
    StatisticsPage(),
    StatisticsPage(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: navPages[selectedPageIndex],
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: selectedPageIndex == 0 ? Colors.pink.shade200 : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  selectedPageIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.bar_chart,
                color: selectedPageIndex == 1 ? Colors.pink.shade200 : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  selectedPageIndex = 1;
                });
              },
            ),
            InkWell(
              onTap: (){
                setState(() {
                  selectedPageIndex = 2;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.pink.shade200,
                  borderRadius: BorderRadius.circular(11)
                ),
                child: Icon(
                  Icons.add,
                  color:  Colors.white ,
                ),

              ),
            ),

            IconButton(
              color: Colors.pink.shade200,
              icon: Icon(
                Icons.notifications,
                color: selectedPageIndex == 3 ? Colors.pink.shade200 : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  selectedPageIndex = 3;
                });
              },
            ),

            IconButton(
              icon: Icon(
                Icons.settings,
                color: selectedPageIndex == 4 ? Colors.pink.shade200 : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  selectedPageIndex = 4;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

///BottomNavigationBar(
//         currentIndex: selectedPageIndex,
//         selectedItemColor: Colors.pink.shade200,
//         showUnselectedLabels: false,
//         showSelectedLabels: false,
//         unselectedItemColor: Colors.grey,
//         onTap: (index){
//           selectedPageIndex = index;
//           setState(() {
//
//           });
//         },
//           items: [
//             BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home", activeIcon: Icon(Icons.home_filled)),
//             BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: "Stats", activeIcon: Icon(Icons.analytics)),
//             BottomNavigationBarItem(icon: Container(
//               width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                     color: Colors.pink.shade200,
//                   borderRadius: BorderRadius.circular(11)
//                 ),
//                 child: Icon(Icons.add, color: Colors.white,)), label: ""),
//             BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: "Notifications", activeIcon: Icon(Icons.notifications)),
//             BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: "Settings", activeIcon: Icon(Icons.settings)),
//           ]
//       )