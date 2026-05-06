import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:personal_expense_tracker/src/features/expenses/domain/entities/expense.dart';

import 'package:personal_expense_tracker/src/features/expenses/presentation/bloc/expense_bloc.dart';
import 'package:personal_expense_tracker/src/features/expenses/presentation/bloc/expense_event.dart';
import 'package:personal_expense_tracker/src/features/expenses/presentation/bloc/expense_state.dart';

import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetExpenses mockGetExpenses;
  late MockAddExpense mockAddExpense;
  late MockDeleteExpense mockDeleteExpense;
  late ExpenseBloc expenseBloc;

  setUp(() {
    mockGetExpenses = MockGetExpenses();
    mockAddExpense = MockAddExpense();
    mockDeleteExpense = MockDeleteExpense();
    expenseBloc = ExpenseBloc(
      getExpenses: mockGetExpenses,
      addExpense: mockAddExpense,
      deleteExpense: mockDeleteExpense,
    );
  });

  tearDown(() {
    expenseBloc.close();
  });

  final tExpense = Expense(
    id: '1',
    title: 'Test Expense',
    amount: 10.0,
    date: DateTime(2023, 1, 1),
  );
  final tExpensesList = [tExpense];

  test('initial state should be ExpenseInitial', () {
    expect(expenseBloc.state, equals(ExpenseInitial()));
  });

  blocTest<ExpenseBloc, ExpenseState>(
    'should emit [ExpenseLoading, ExpenseLoaded] when LoadExpensesEvent is added',
    build: () {
      when(mockGetExpenses()).thenAnswer((_) async => tExpensesList);
      return expenseBloc;
    },
    act: (bloc) => bloc.add(LoadExpensesEvent()),
    expect: () => [ExpenseLoading(), ExpenseLoaded(expenses: tExpensesList)],
  );

  blocTest<ExpenseBloc, ExpenseState>(
    'should emit [ExpenseLoading, ExpenseError] when LoadExpensesEvent fails',
    build: () {
      when(mockGetExpenses()).thenThrow(Exception('Server Failure'));
      return expenseBloc;
    },
    act: (bloc) => bloc.add(LoadExpensesEvent()),
    expect: () => [
      ExpenseLoading(),
      const ExpenseError(message: 'Exception: Server Failure'),
    ],
  );

  blocTest<ExpenseBloc, ExpenseState>(
    'should call addExpense and trigger LoadExpensesEvent when AddExpenseEvent is added',
    build: () {
      when(mockAddExpense(tExpense)).thenAnswer((_) async => {});
      when(mockGetExpenses()).thenAnswer((_) async => tExpensesList);
      return expenseBloc;
    },
    act: (bloc) => bloc.add(AddExpenseEvent(expense: tExpense)),
    expect: () => [ExpenseLoading(), ExpenseLoaded(expenses: tExpensesList)],
    verify: (_) {
      verify(mockAddExpense(tExpense));
    },
  );

  blocTest<ExpenseBloc, ExpenseState>(
    'should call deleteExpense and trigger LoadExpensesEvent when DeleteExpenseEvent is added',
    build: () {
      when(mockDeleteExpense('1')).thenAnswer((_) async => {});
      when(mockGetExpenses()).thenAnswer((_) async => []);
      return expenseBloc;
    },
    act: (bloc) => bloc.add(const DeleteExpenseEvent(id: '1')),
    expect: () => [ExpenseLoading(), const ExpenseLoaded(expenses: [])],
    verify: (_) {
      verify(mockDeleteExpense('1'));
    },
  );
}
