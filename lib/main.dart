import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personal_expenses_app/model/transaction.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import 'package:personal_expenses_app/widgets/new_transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Manager',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFF003c7e),
          accentColor: Color(0xFF4487c7),
          fontFamily: 'Mali',
          textTheme: TextTheme(headline1: TextStyle(fontSize: 36))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        id: Random().nextDouble(),
        title: 'T-Shirt',
        amount: 525.00,
        dateTime: DateTime.now()),
    Transaction(
        id: Random().nextDouble(),
        title: 'Food',
        amount: 125.00,
        dateTime: DateTime.now()),
    Transaction(
        id: Random().nextDouble(),
        title: 'Taxi',
        amount: 100.00,
        dateTime: DateTime.now()),
    Transaction(
        id: Random().nextDouble(),
        title: 'T-Shirt1',
        amount: 525.00,
        dateTime: DateTime.now()),
    Transaction(
        id: Random().nextDouble(),
        title: 'Food1',
        amount: 125.00,
        dateTime: DateTime.now()),
    Transaction(
        id: Random().nextDouble(),
        title: 'Taxi1',
        amount: 100.00,
        dateTime: DateTime.now()),
  ];

  void _addTransaction(String title, double amount, DateTime selectedDate) {
    final Transaction newTxn = Transaction(
      id: Random().nextDouble(),
      title: title,
      amount: amount,
      dateTime: selectedDate,
    );
    setState(() {
      _transactions.add(newTxn);
    });
  }

  void _deleteTransaction(double id) {
    setState(() {
      _transactions.removeWhere((element) => (element.id == id));
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    _transactions
        .where(
          (element) => (element.dateTime.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          )),
        )
        .toList();

    return _transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses Manager'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_transactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
