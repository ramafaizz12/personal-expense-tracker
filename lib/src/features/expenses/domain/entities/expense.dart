import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  @override
  List<Object?> get props => [id, title, amount, date];
}
