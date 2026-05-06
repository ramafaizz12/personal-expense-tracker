import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:personal_expense_tracker/src/features/expenses/domain/entities/expense.dart';
import 'package:personal_expense_tracker/src/features/expenses/presentation/bloc/expense_bloc.dart';
import 'package:personal_expense_tracker/src/features/expenses/presentation/bloc/expense_event.dart';

class AddExpenseBottomSheet extends HookWidget {
  const AddExpenseBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final amountController = useTextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Add New Expense',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
              prefixText: '\$ ',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {
              final title = titleController.text;
              final amount = double.tryParse(amountController.text) ?? 0.0;

              if (title.isNotEmpty && amount > 0) {
                final expense = Expense(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: title,
                  amount: amount,
                  date: DateTime.now(),
                );

                context.read<ExpenseBloc>().add(
                  AddExpenseEvent(expense: expense),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Save Expense'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}


void showAddExpenseBottomSheet(BuildContext context) {
  final expenseBloc = context.read<ExpenseBloc>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return BlocProvider.value(
        value: expenseBloc,
        child: const AddExpenseBottomSheet(),
      );
    },
  );
}
