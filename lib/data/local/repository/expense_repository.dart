import 'package:expenser_378/data/local/helper/db_helper.dart';

import '../model/expense_model.dart';

class ExpenseRepository {

  DBHelper dbHelper;
  ExpenseRepository({required this.dbHelper});

  Future<bool> addExpense({required ExpenseModel expenseModel}) async {
    bool check = await dbHelper.addNewExpense(newExp: expenseModel);
    return check;
  }

  Future<List<ExpenseModel>> fetchAllExpenses() async{
    return await dbHelper.getAllExpenses();
  }

  ///update
  ///delete


}