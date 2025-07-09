import 'package:expenser_378/data/local/model/filtered_exp_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {

  List<FilteredExpenseModel> allExp = [
    FilteredExpenseModel(title: "Grocery", totalAmt: 1000, expList: []),
    FilteredExpenseModel(title: "Petrol", totalAmt: 7000, expList: []),
    FilteredExpenseModel(title: "Shopping", totalAmt: 10000, expList: []),
    FilteredExpenseModel(title: "Recharge", totalAmt: 2400, expList: []),
    FilteredExpenseModel(title: "Coffee", totalAmt: 2700, expList: [],),
    FilteredExpenseModel(title: "Restaurant", totalAmt: 7700, expList: [],),
  ];

  @override
  Widget build(BuildContext context) {

    List<BarChartGroupData> mBar = [];

    for(int i = 0; i<allExp.length; i++){
      mBar.add(BarChartGroupData(x: i, barRods: [_barUI(toY: allExp[i].totalAmt.toDouble())]));
    }


    return Scaffold(
      body: Center(
        child: Container(
          height: 250,
          width: double.infinity,
          child: BarChart(
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
          ),
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
