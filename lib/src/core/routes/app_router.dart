import 'package:go_router/go_router.dart';

import '../../features/expenses/domain/entities/expense.dart';
import '../../features/expenses/presentation/pages/expense_detail_page.dart';
import '../../features/expenses/presentation/pages/expenses_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'expenses',
      builder: (context, state) => const ExpensesPage(),
    ),
    GoRoute(
      path: '/detail',
      name: 'expense_detail',
      builder: (context, state) {
        final expense = state.extra as Expense;
        return ExpenseDetailPage(expense: expense);
      },
    ),
  ],
);
