import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_expense.dart';
import '../../domain/usecases/delete_expense.dart';
import '../../domain/usecases/get_expenses.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final GetExpenses getExpenses;
  final AddExpense addExpense;
  final DeleteExpense deleteExpense;

  ExpenseBloc({
    required this.getExpenses,
    required this.addExpense,
    required this.deleteExpense,
  }) : super(ExpenseInitial()) {
    on<LoadExpensesEvent>((event, emit) async {
      emit(ExpenseLoading());
      try {
        final expenses = await getExpenses();
        emit(ExpenseLoaded(expenses: expenses));
      } catch (e) {
        emit(ExpenseError(message: e.toString()));
      }
    });

    on<AddExpenseEvent>((event, emit) async {
      try {
        await addExpense(event.expense);
        add(LoadExpensesEvent());
      } catch (e) {
        emit(ExpenseError(message: e.toString()));
      }
    });

    on<DeleteExpenseEvent>((event, emit) async {
      try {
        await deleteExpense(event.id);
        add(LoadExpensesEvent());
      } catch (e) {
        emit(ExpenseError(message: e.toString()));
      }
    });
  }
}
