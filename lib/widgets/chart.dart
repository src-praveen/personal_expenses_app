import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/model/transaction.dart';
import 'package:personal_expenses_app/model/transaction_value.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _transactions;
  Chart(this._transactions);

  List<TransactionValue> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double amountPerDay = 0;
      for (var txn in _transactions) {
        if (txn.dateTime.day == weekDay.day &&
            txn.dateTime.month == weekDay.month &&
            txn.dateTime.year == weekDay.year) {
          amountPerDay += txn.amount;
        }
      }
      return TransactionValue(
        DateFormat.E().format(weekDay).substring(0, 1),
        amountPerDay,
      );
    }).reversed.toList();
  }

  double get _maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(e.day, e.amount, e.amount / _maxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
