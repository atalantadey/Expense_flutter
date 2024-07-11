import 'package:expense/widgets/chart/chart.dart';
import 'package:expense/widgets/expenses_list/expense_list.dart';
import 'package:expense/models/expense.dart';
import 'package:expense/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        date: DateTime.now(),
        tittle: 'Flutter',
        amount: 99.99,
        category: Category.work),
    Expense(
        date: DateTime.now(),
        tittle: 'Cinema',
        amount: 12.99,
        category: Category.leisure),
    Expense(
        date: DateTime.now(),
        tittle: 'FIFA',
        amount: 49.99,
        category: Category.leisure),
    Expense(
        date: DateTime.now(),
        tittle: 'Sandwhich',
        amount: 9.99,
        category: Category.food),
  ];

  void _openAddExpense() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpenses),
    );
  }

  void _addExpenses(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpenses(Expense expense) {
    final ExpenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(ExpenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width);
    //final height = (MediaQuery.of(context).size.height);
    Widget mainContent = const Center(
      child: Text('No Expenses Found. Start Adding Some!!'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registeredExpenses,
        onRemove: _removeExpenses,
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: _openAddExpense, icon: const Icon(Icons.add_outlined)),
        ],
        //backgroundColor: const Color.fromARGB(255, 179, 255, 189),
        title: const Text('Flutter Expense Tracker'),
      ),
      body: Center(
        child: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(child: mainContent),
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(child: mainContent),
                ],
              ),
      ),
    );
  }
}
