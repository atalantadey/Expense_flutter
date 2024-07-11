import 'package:expense/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(
    this.expense, {
    super.key,
  });
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: const Color.fromARGB(255, 113, 255, 113),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.tittle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                Text(
                    'Rs ${expense.amount.toStringAsFixed(2)}'), //ensures that a value like 12.23344=>12.23
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryItems[expense.category]),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
