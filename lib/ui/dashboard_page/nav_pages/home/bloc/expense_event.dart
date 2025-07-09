import 'package:expenser_378/data/local/model/expense_model.dart';

abstract class ExpenseEvent{}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExpense;
  AddExpenseEvent({required this.newExpense});
}

class FetchInitialExpenseEvent extends ExpenseEvent{
  int filterType;
  FetchInitialExpenseEvent({this.filterType = 1});
}