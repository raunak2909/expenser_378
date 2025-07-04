import 'package:expenser_378/data/local/model/expense_model.dart';
import 'package:expenser_378/data/local/model/filtered_exp_model.dart';

abstract class ExpenseState{}

class ExpenseInitialState extends ExpenseState{}
class ExpenseLoadingState extends ExpenseState{}
class ExpenseLoadedState extends ExpenseState{
  List<FilteredExpenseModel> allExp;
  ExpenseLoadedState({required this.allExp});
}
class ExpenseErrorState extends ExpenseState{
  String errorMsg;
  ExpenseErrorState({required this.errorMsg});
}