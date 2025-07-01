import 'package:expenser_378/data/local/model/expense_model.dart';
import 'package:expenser_378/ui/home/bloc/expense_bloc.dart';
import 'package:expenser_378/ui/home/bloc/expense_event.dart';
import 'package:expenser_378/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/bloc/expense_state.dart';

class AddExpensePage extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController amtController = TextEditingController();

  String selectedType = "Debit";
  List<String> mType = ["Debit", "Credit"];
  RangeValues selectedRange = RangeValues(200, 400);
  DateTime? selectedDate;
  DateFormat df = DateFormat.yMMMEd();
  int selectedCatIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),

      body: Padding(
        padding: EdgeInsets.all(21),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
                prefixIcon: Icon(Icons.title),
                filled: true,
                fillColor: Color(0xFFDDF6D2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
            ),
            SizedBox(height: 11),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                hintText: "Desc",
                prefixIcon: Icon(Icons.description),
                filled: true,
                fillColor: Color(0xFFDDF6D2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
            ),
            SizedBox(height: 11),
            TextField(
              keyboardType: TextInputType.number,
              controller: amtController,
              decoration: InputDecoration(
                hintText: "Amount",
                prefixIcon: Icon(Icons.money),
                filled: true,
                fillColor: Color(0xFFDDF6D2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
            ),
            SizedBox(height: 11),
            /*StatefulBuilder(
              builder: (context, ss) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RadioMenuButton(
                      value: "Debit",
                      groupValue: selectedType,
                      onChanged: (value) {
                        selectedType = value!;
                        ss(() {});
                      },
                      child: Text('Debit'),
                    ),
                    RadioMenuButton(
                      value: "Credit",
                      groupValue: selectedType,
                      onChanged: (value) {
                        selectedType = value!;
                        ss(() {});
                      },
                      child: Text('Credit'),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 11),*/
            /*StatefulBuilder(
            builder: (context,ss) {
              return DropdownButton<String>(
                value: selectedType,
                items: [
                  DropdownMenuItem(child: Text('Debit'), value: "Debit",),
                  DropdownMenuItem(child: Text('Credit'), value: "Credit",),
                ],
                onChanged: (value){
                  selectedType = value!;
                  ss(() {});
                },
              );
            }
          ),*/
            DropdownMenu(
              initialSelection: selectedType,
              width: double.infinity,
              menuStyle: MenuStyle(
                alignment: Alignment.bottomLeft,
                minimumSize: WidgetStatePropertyAll(
                  Size(MediaQuery.of(context).size.width - 42, 100),
                ),
                maximumSize: WidgetStatePropertyAll(
                  Size(MediaQuery.of(context).size.width - 42, 100),
                ),
                backgroundColor: WidgetStatePropertyAll(Color(0xFFDDF6D2)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Color(0xFFDDF6D2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
              dropdownMenuEntries: mType.map((e) {
                return DropdownMenuEntry(value: e, label: e);
              }).toList(),
            ),

            /*StatefulBuilder(
              builder: (context, ss) {
                return RangeSlider(
                  activeColor: Colors.amber,
                  inactiveColor: Colors.amber.shade100,
                  divisions: 200,
                  labels: RangeLabels(selectedRange.start.toString(), selectedRange.end.toString()),
                  min: 100,
                    max: 1000,
                    values: selectedRange, onChanged: (value){
                    selectedRange = value;
                    ss(() {});
                });
              }
            )*/
            SizedBox(height: 11),
            SizedBox(
              width: double.infinity,
              child: StatefulBuilder(
                builder: (context, ss) {
                  return OutlinedButton(
                    onPressed: () async {
                      selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now().subtract(Duration(days: 730)),
                        lastDate: DateTime.now(),
                      );
                      ss(() {});
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 55),
                      backgroundColor: Color(0xFFDDF6D2),
                      side: BorderSide(width: 1, color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                    ),
                    child: Text(
                      df.format(selectedDate ?? DateTime.now()),
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 11),
            SizedBox(
              width: double.infinity,
              child: StatefulBuilder(
                builder: (context, ss) {
                  return OutlinedButton(
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 11),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                  ),
                              itemCount: AppConstants.mCatList.length,
                              itemBuilder: (_, index) {
                                return InkWell(
                                  onTap: () {
                                    selectedCatIndex = index;
                                    ss(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        AppConstants.mCatList[index].catImg,
                                        width: 50,
                                        height: 50,
                                      ),
                                      SizedBox(height: 11),
                                      Text(
                                        AppConstants.mCatList[index].catName,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 55),
                      backgroundColor: Color(0xFFDDF6D2),
                      side: BorderSide(width: 1, color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                    ),
                    child: selectedCatIndex < 0
                        ? Text(
                            "Select Category",
                            style: TextStyle(fontSize: 16),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppConstants.mCatList[selectedCatIndex].catImg,
                                width: 30,
                                height: 30,
                              ),
                              Text(
                                " - ${AppConstants.mCatList[selectedCatIndex].catName}",
                              ),
                            ],
                          ),
                  );
                },
              ),
            ),
            SizedBox(height: 11),
            SizedBox(
              width: double.infinity,
              child: BlocListener<ExpenseBloc, ExpenseState>(
                listener: (context, state) {

                  if(state is ExpenseErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
                  }

                  if(state is ExpenseLoadingState){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 11),
                        Text("Adding your expense..."),
                      ],
                    ), duration: Duration(milliseconds: 200), backgroundColor: Colors.green,));
                  }

                  if(state is ExpenseLoadedState) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(
                      children: [
                        Icon(Icons.done),
                        SizedBox(width: 11),
                        Text("Expense added successfully"),
                      ],
                    ), backgroundColor: Colors.amber,));
                  }

                },
                child: OutlinedButton(
                  onPressed: () async {
                    if (titleController.text.isNotEmpty &&
                        descController.text.isNotEmpty &&
                        amtController.text.isNotEmpty) {
                      if (selectedCatIndex >= 0) {
                        String title = titleController.text;
                        String desc = descController.text;
                        num amt = double.parse(amtController.text);
                        num bal = 0;
                        String createdAt = (selectedDate ?? DateTime.now())
                            .millisecondsSinceEpoch
                            .toString();
                        int catId = AppConstants.mCatList[selectedCatIndex].catId;

                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        int userId =
                            prefs.getInt(AppConstants.PREF_USER_ID_KEY) ?? 0;

                        ExpenseModel newExp = ExpenseModel(
                          user_id: userId,
                          title: title,
                          desc: desc,
                          amt: amt,
                          bal: bal,
                          cat_id: catId,
                          created_at: createdAt,
                          type: selectedType == "Debit" ? 1 : 2,
                        );

                        context.read<ExpenseBloc>().add(
                          AddExpenseEvent(newExpense: newExp),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please select a category")),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please fill all the fields")),
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55),
                    backgroundColor: Color(0xFF559F34),
                    side: BorderSide(width: 1, color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                  child: Text(
                    "Add Expense",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
