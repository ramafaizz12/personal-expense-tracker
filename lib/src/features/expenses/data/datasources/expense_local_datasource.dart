import 'package:hive/hive.dart';

import '../models/expense_model.dart';

abstract class ExpenseLocalDataSource {
  Future<List<ExpenseModel>> getExpenses();
  Future<void> addExpense(ExpenseModel expense);
  Future<void> deleteExpense(String id);
}

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final String _boxName = 'expenses_box';

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    final box = await Hive.openBox<ExpenseModel>(_boxName);
    await box.put(expense.id, expense);
  }

  @override
  Future<void> deleteExpense(String id) async {
    final box = await Hive.openBox<ExpenseModel>(_boxName);
    await box.delete(id);
  }

  @override
  Future<List<ExpenseModel>> getExpenses() async {
    final box = await Hive.openBox<ExpenseModel>(_boxName);
    return box.values.toList().cast<ExpenseModel>();
  }
}
