import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/src/features/expenses/domain/entities/expense.dart';
import 'package:personal_expense_tracker/src/features/expenses/presentation/bloc/expense_bloc.dart';
import 'package:personal_expense_tracker/src/features/expenses/presentation/bloc/expense_event.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(symbol: '\$');
    final formattedAmount = formatter.format(expense.amount);
    final formattedDate = DateFormat('MMM dd, yyyy').format(expense.date);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        title: Text(
          expense.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(formattedDate),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              formattedAmount,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                context.read<ExpenseBloc>().add(
                  DeleteExpenseEvent(id: expense.id),
                );
              },
            ),
          ],
        ),
        onTap: () {
          context.push('/detail', extra: expense);
        },
      ),
    );
  }
}
