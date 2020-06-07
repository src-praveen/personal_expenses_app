import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final List<Transaction> transactions = [
    Transaction(
        id: '1001', title: 'T-Shirt', amount: 525.00, dateTime: DateTime.now()),
    Transaction(
        id: '1002', title: 'Food', amount: 125.00, dateTime: DateTime.now()),
    Transaction(
        id: '1003', title: 'Taxi', amount: 100.00, dateTime: DateTime.now()),
  ];

  final TextEditingController titleContoller = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String amountInput;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Expenses Manager'),
            centerTitle: true,
            backgroundColor: Colors.purple,
          ),
          body: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  child: Text('Chart Comes here'),
                  color: Colors.blueGrey,
                  elevation: 5,
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                        ),
                        controller: titleContoller,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Amount(Rs.)',
                        ),
                        controller: amountController,
                      ),
                      FlatButton(
                        onPressed: () {
                          print(titleContoller.text);
                          print(amountController.text);
                        },
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.purple,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Add Transaction',
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: transactions.map(
                  (txn) {
                    return Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 10,
                              right: 10,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.purple,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              "Rs.${txn.amount}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.purpleAccent,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                txn.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black87),
                              ),
                              Text(
                                DateFormat.yMMMd().format(txn.dateTime),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
