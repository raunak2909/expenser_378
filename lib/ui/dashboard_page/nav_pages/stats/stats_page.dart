import 'package:expenser_378/data/local/model/filtered_exp_model.dart';
import 'package:expenser_378/ui/dashboard_page/nav_pages/home/bloc/expense_bloc.dart';
import 'package:expenser_378/ui/dashboard_page/nav_pages/home/bloc/expense_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/bloc/expense_event.dart';

class StatisticsPage extends StatelessWidget {

  List<FilteredExpenseModel> allExp = [
    FilteredExpenseModel(title: "Grocery", totalAmt: 1000, expList: []),
    FilteredExpenseModel(title: "Petrol", totalAmt: 7000, expList: []),
    FilteredExpenseModel(title: "Shopping", totalAmt: 10000, expList: []),
    FilteredExpenseModel(title: "Recharge", totalAmt: 2400, expList: []),
    FilteredExpenseModel(title: "Coffee", totalAmt: 2700, expList: [],),
    FilteredExpenseModel(title: "Restaurant", totalAmt: 7700, expList: [],),
  ];

  String mSelectedFilterType = "Date";
  List<String> mFilterTypes = [
    "Date",
    "Month",
    "Year",
    "Category",
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 11),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 60,
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: AssetImage("assets/images/soumik_profile.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Morning",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      Text("Soumik Nath", style: TextStyle(fontSize: 16)),
                    ],
                  ),

                  Spacer(),
                  DropdownMenu(
                    initialSelection: mSelectedFilterType,
                    width: 150,
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: Color(0xFFDDF6D2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                    ),
                    onSelected: (value) {
                      mSelectedFilterType = value!;
                      int filterType;
                      if (value == "Date") {
                        filterType = 1;
                      } else if (value == "Month") {
                        filterType = 2;
                      } else if (value == "Year") {
                        filterType = 3;
                      } else {
                        filterType = 4;
                      }
                      context.read<ExpenseBloc>().add(
                        FetchInitialExpenseEvent(filterType: filterType),
                      );
                    },
                    dropdownMenuEntries: mFilterTypes.map((e) {
                      return DropdownMenuEntry(value: e, label: e);
                    }).toList(),
                  ),

                  /*Container(
                      width: 140,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('This month',style: TextStyle(fontSize: 16),),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    )*/
                ],
              ),
            ),
            SizedBox(height: 51),
            Container(
              height: 250,
              width: double.infinity,
              child: BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {
                  if(state is ExpenseLoadingState){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if(state is ExpenseLoadedState){
                    allExp = state.allExp;

                    if(mSelectedFilterType=="Date"){
                      //pie chart

                      List<PieChartSectionData> mPie = [];

                      for(int i = 0; i<allExp.length; i++){
                        mPie.add(PieChartSectionData(
                          radius: 120,
                          badgeWidget: Text(allExp[i].title, style: TextStyle(fontSize: 12),),
                          badgePositionPercentageOffset: 1.2,
                          titleStyle: TextStyle(fontSize: 11, color: Colors.white),
                          value: allExp[i].totalAmt<0 ? allExp[i].totalAmt*-1.0 : allExp[i].totalAmt.toDouble(),
                          color: Colors.primaries[i%Colors.primaries.length],
                        ));
                      }

                      return PieChart(PieChartData(
                        sections: mPie,
                        centerSpaceRadius: 10,
                      ), duration: Duration(seconds: 2),
                        curve: Curves.decelerate,);

                    } else {
                      //bar chart
                      List<BarChartGroupData> mBar = [];

                      for(int i = 0; i<allExp.length; i++){
                        mBar.add(BarChartGroupData(x: i, barRods: [_barUI(toY: allExp[i].totalAmt<0 ? allExp[i].totalAmt*-1.0 : allExp[i].totalAmt.toDouble())]));
                      }

                      return BarChart(
                        duration: Duration(seconds: 2),
                        curve: Curves.fastLinearToSlowEaseIn,
                        BarChartData(
                            titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta){
                                          return Text(allExp[value.toInt()].title, style: TextStyle(fontSize: 11),);
                                        }
                                    )
                                )
                            ),
                            barGroups: mBar
                        ),
                      );
                    }
                  }
                  if(state is ExpenseErrorState){
                    return Center(child: Text(state.errorMsg),);
                  }
                  return Container();
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartRodData _barUI({required double toY}) {
    return BarChartRodData(
      toY: toY,
      color: Colors.blue,
      width: 35,
      borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
    );
  }
}

///Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Container(
//                 width: 50,
//                 height: 100,
//                 color: Colors.purple,
//               ),
//               Container(
//                 width: 50,
//                 height: 120,
//                 color: Colors.purple,
//               ),
//               Container(
//                 width: 50,
//                 height: 40,
//                 color: Colors.purple,
//               ),
//               Container(
//                 width: 50,
//                 height: 170,
//                 color: Colors.purple,
//               ),
//               Container(
//                 width: 50,
//                 height: 70,
//                 color: Colors.purple,
//               ),
//             ],
//           )
