import 'package:expense/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  final formatter = DateFormat.yMd();
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final FD = DateTime(now.year - 1, now.month - 1, now.day);
    final pickedDate = await showDatePicker(
        context: context, initialDate: now, firstDate: FD, lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredNo = double.tryParse(
        _amountController.text); //tryparse('Hello)=> null ..Trypars(1.12)=>1.12
    final amountIsInvalid = enteredNo == null || enteredNo <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid == true ||
        _selectedDate == null) {
      //show Error Message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please Make Sure a Valid Title and Amount was Entered'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(Expense(
        date: _selectedDate!,
        tittle: _titleController.text,
        amount: enteredNo!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      print(constraints.minWidth);
      print(constraints.maxWidth);
      print(constraints.minHeight);
      print(constraints.maxHeight);
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
          child: Column(
            children: [
              if (width >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        maxLength: 50,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(label: Text('Title')),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: 'Rs ',
                          label: Text('Amount'),
                        ),
                      ),
                    ),
                  ],
                )
              else
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(label: Text('Title')),
                ),
              if (width >= 600)
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value == null) {
                              return;
                            }
                            _selectedCategory = value;
                          });
                        }),
                    const SizedBox(
                      height: 6,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No Date Selected'
                                : formatter.format(_selectedDate!),
                          ),
                          IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.date_range))
                        ],
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: 'Rs ',
                          label: Text('Amount'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No Date Selected'
                                : formatter.format(_selectedDate!),
                          ),
                          IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.date_range))
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 10,
              ),
              if (width > 600)
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text('Save Expense'),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null) {
                            return;
                          }
                          _selectedCategory = value;
                        });
                      },
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text('Save Expense'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
    });
  }
}
