import 'package:expenser_378/data/local/helper/db_helper.dart';
import 'package:expenser_378/data/local/model/filtered_exp_model.dart';
import 'package:intl/intl.dart';

import '../model/expense_model.dart';

class ExpenseRepository {
  DBHelper dbHelper;

  ExpenseRepository({required this.dbHelper});

  Future<bool> addExpense({required ExpenseModel expenseModel}) async {
    bool check = await dbHelper.addNewExpense(newExp: expenseModel);
    return check;
  }

  Future<List<FilteredExpenseModel>> fetchAllExpenses({
    int filterType = 1,
  }) async {
    ///1-> date wise, 2-> month wise, 3-> year wise, 4-> cat wise
    var allExp = await dbHelper.getAllExpenses();

    List<FilteredExpenseModel> mFilteredExp = [];
    DateFormat df = DateFormat.yMMMEd();

    ///date wise
    ///1
    List<String> uniqueDates = [];

    for (ExpenseModel eachExp in allExp) {
      String eachDate = df.format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.created_at)),
      );

      if (!uniqueDates.contains(eachDate)) {
        uniqueDates.add(eachDate);
      }
    }
    print(uniqueDates);

    ///2
    for (String eachDate in uniqueDates) {
      num totalAmt = 0.0;
      List<ExpenseModel> mExpByDate = [];

      for (ExpenseModel eachExp in allExp) {
        String expDate = df.format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.created_at)),
        );

        if(eachDate == expDate){
          mExpByDate.add(eachExp);

          if(eachExp.type==1){///debit
            totalAmt -= eachExp.amt;
          } else {///credit
            totalAmt += eachExp.amt;
          }

        }
      }

      mFilteredExp.add(FilteredExpenseModel(title: eachDate, totalAmt: totalAmt, expList: mExpByDate));

    }

    print(mFilteredExp.length);

    return mFilteredExp;
  }

  ///update
  ///delete
}
