import 'package:expense/models/expense.dart';
import 'package:expense/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemove});

  final void Function(Expense expense) onRemove;
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.9),
          margin: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: ExpenseItem(expenses[index]),
        onDismissed: (direction) {
          onRemove(expenses[index]);
        },
      ),
    );
  }
}
