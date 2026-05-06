import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:personal_expense_tracker/src/features/expenses/domain/entities/expense.dart';
import 'package:personal_expense_tracker/src/features/expenses/domain/usecases/add_expense.dart';
import 'package:personal_expense_tracker/src/features/expenses/domain/usecases/delete_expense.dart';
import 'package:personal_expense_tracker/src/features/expenses/domain/usecases/get_expenses.dart';

import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockExpenseRepository mockExpenseRepository;
  late AddExpense addExpense;
  late GetExpenses getExpenses;
  late DeleteExpense deleteExpense;

  setUp(() {
    mockExpenseRepository = MockExpenseRepository();
    addExpense = AddExpense(mockExpenseRepository);
    getExpenses = GetExpenses(mockExpenseRepository);
    deleteExpense = DeleteExpense(mockExpenseRepository);
  });

  final tExpense = Expense(
    id: '1',
    title: 'Test Expense',
    amount: 10.0,
    date: DateTime(2023, 1, 1),
  );
  final tExpensesList = [tExpense];

  group('AddExpense', () {
    test('should call repository.addExpense with correct parameter', () async {
      // arrange
      when(mockExpenseRepository.addExpense(any)).thenAnswer((_) async => {});
      // act
      await addExpense(tExpense);
      // assert
      verify(mockExpenseRepository.addExpense(tExpense));
      verifyNoMoreInteractions(mockExpenseRepository);
    });
  });

  group('GetExpenses', () {
    test('should return list of expenses from repository', () async {
      // arrange
      when(
        mockExpenseRepository.getExpenses(),
      ).thenAnswer((_) async => tExpensesList);
      // act
      final result = await getExpenses();
      // assert
      expect(result, tExpensesList);
      verify(mockExpenseRepository.getExpenses());
      verifyNoMoreInteractions(mockExpenseRepository);
    });
  });

  group('DeleteExpense', () {
    test('should call repository.deleteExpense with correct id', () async {
      // arrange
      when(
        mockExpenseRepository.deleteExpense(any),
      ).thenAnswer((_) async => {});
      // act
      await deleteExpense('1');
      // assert
      verify(mockExpenseRepository.deleteExpense('1'));
      verifyNoMoreInteractions(mockExpenseRepository);
    });
  });
}
