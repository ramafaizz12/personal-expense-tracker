import 'package:get_it/get_it.dart';

import '../../features/expenses/data/datasources/expense_local_datasource.dart';
import '../../features/expenses/data/repositories/expense_repository_impl.dart';
import '../../features/expenses/domain/repositories/expense_repository.dart';
import '../../features/expenses/domain/usecases/add_expense.dart';
import '../../features/expenses/domain/usecases/delete_expense.dart';
import '../../features/expenses/domain/usecases/get_expenses.dart';
import '../../features/expenses/presentation/bloc/expense_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ExpenseBloc(
        getExpenses: sl(),
        addExpense: sl(),
        deleteExpense: sl(),
      ));

  // UseCases
  sl.registerLazySingleton(() => GetExpenses(sl()));
  sl.registerLazySingleton(() => AddExpense(sl()));
  sl.registerLazySingleton(() => DeleteExpense(sl()));

  // Repository
  sl.registerLazySingleton<ExpenseRepository>(
      () => ExpenseRepositoryImpl(localDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<ExpenseLocalDataSource>(
      () => ExpenseLocalDataSourceImpl());
}
