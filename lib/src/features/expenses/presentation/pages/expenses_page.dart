import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../bloc/expense_bloc.dart';
import '../bloc/expense_event.dart';
import '../bloc/expense_state.dart';
import '../widgets/add_expense_bottom_sheet.dart';
import '../widgets/expense_card.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ExpenseBloc>()..add(LoadExpensesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Expense Tracker'),
          elevation: 0,
        ),
        body: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
            if (state is ExpenseLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ExpenseLoaded) {
              if (state.expenses.isEmpty) {
                return const Center(child: Text('No expenses yet. Add some!'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: state.expenses.length,
                itemBuilder: (context, index) {
                  final expense = state.expenses[index];
                  return ExpenseCard(expense: expense);
                },
              );
            } else if (state is ExpenseError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox();
          },
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () => showAddExpenseBottomSheet(context),
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
