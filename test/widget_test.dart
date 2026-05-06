import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/src/core/di/injection_container.dart'
    as di;
import 'package:personal_expense_tracker/src/features/expenses/domain/entities/expense.dart';
import 'package:personal_expense_tracker/src/features/expenses/presentation/bloc/expense_bloc.dart';
import 'package:personal_expense_tracker/src/features/expenses/presentation/bloc/expense_event.dart';
import 'package:personal_expense_tracker/src/features/expenses/presentation/bloc/expense_state.dart';
import 'package:personal_expense_tracker/src/features/expenses/presentation/pages/expenses_page.dart';

class MockExpenseBloc extends MockBloc<ExpenseEvent, ExpenseState>
    implements ExpenseBloc {}

void main() {
  late MockExpenseBloc mockExpenseBloc;

  setUp(() {
    mockExpenseBloc = MockExpenseBloc();
    di.sl.registerFactory<ExpenseBloc>(() => mockExpenseBloc);
  });

  tearDown(() {
    di.sl.reset();
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(home: body);
  }

  testWidgets('should show loading indicator when state is ExpenseLoading', (
    WidgetTester tester,
  ) async {
    // arrange
    when(() => mockExpenseBloc.state).thenReturn(ExpenseLoading());
    // act
    await tester.pumpWidget(makeTestableWidget(const ExpensesPage()));
    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
    'should show empty message when state is ExpenseLoaded and empty',
    (WidgetTester tester) async {
      // arrange
      when(
        () => mockExpenseBloc.state,
      ).thenReturn(const ExpenseLoaded(expenses: []));
      // act
      await tester.pumpWidget(makeTestableWidget(const ExpensesPage()));
      // assert
      expect(find.text('No expenses yet. Add some!'), findsOneWidget);
    },
  );

  testWidgets('should show list of expenses when state is ExpenseLoaded', (
    WidgetTester tester,
  ) async {
    // arrange
    final tExpenses = [
      Expense(
        id: '1',
        title: 'Groceries',
        amount: 50.0,
        date: DateTime(2023, 1, 1),
      ),
    ];
    when(
      () => mockExpenseBloc.state,
    ).thenReturn(ExpenseLoaded(expenses: tExpenses));
    // act
    await tester.pumpWidget(makeTestableWidget(const ExpensesPage()));
    // assert
    expect(find.text('Groceries'), findsOneWidget);
    expect(find.text('\$50.00'), findsOneWidget);
  });
}
