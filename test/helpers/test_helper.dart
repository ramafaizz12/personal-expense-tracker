import 'package:mockito/annotations.dart';
import 'package:personal_expense_tracker/src/features/expenses/domain/repositories/expense_repository.dart';
import 'package:personal_expense_tracker/src/features/expenses/domain/usecases/add_expense.dart';
import 'package:personal_expense_tracker/src/features/expenses/domain/usecases/delete_expense.dart';
import 'package:personal_expense_tracker/src/features/expenses/domain/usecases/get_expenses.dart';

@GenerateMocks([
  ExpenseRepository,
  GetExpenses,
  AddExpense,
  DeleteExpense,
])
void main() {}
