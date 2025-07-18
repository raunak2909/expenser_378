
import 'package:expenser_378/data/local/model/filtered_exp_model.dart';
import 'package:expenser_378/data/local/repository/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState>{
  ExpenseRepository expenseRepository;
  ExpenseBloc({required this.expenseRepository}) : super(ExpenseInitialState()){
    
    on<AddExpenseEvent>((event, emit) async{
      
      emit(ExpenseLoadingState());
      
      bool check = await expenseRepository.addExpense(expenseModel: event.newExpense);

      if(check){
        ///get all expense
        var mExp = await expenseRepository.fetchAllExpenses();
        emit(ExpenseLoadedState(allExp: mExp));
      } else {
        emit(ExpenseErrorState(errorMsg: "Expense not added"));
      }

    });

    on<FetchInitialExpenseEvent>((event, emit) async{
      emit(ExpenseLoadingState());

      List<FilteredExpenseModel > mExp = await expenseRepository.fetchAllExpenses(filterType: event.filterType);

      emit(ExpenseLoadedState(allExp: mExp));
    });
    
  }
  
}