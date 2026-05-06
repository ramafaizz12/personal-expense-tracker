import '../../domain/entities/expense.dart';
import '../../domain/repositories/expense_repository.dart';
import '../datasources/expense_local_datasource.dart';
import '../models/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;

  ExpenseRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addExpense(Expense expense) async {
    final model = ExpenseModel.fromEntity(expense);
    return localDataSource.addExpense(model);
  }

  @override
  Future<void> deleteExpense(String id) async {
    return localDataSource.deleteExpense(id);
  }

  @override
  Future<List<Expense>> getExpenses() async {
    final models = await localDataSource.getExpenses();
    // In Dart, since ExpenseModel extends Expense, we can cast it
    return models;
  }
}
