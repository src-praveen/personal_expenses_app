import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransactionHandler;
  NewTransaction(this._addTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleContoller = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime _transactionDate;

  void _submitData() {
    final _enteredTitle = _titleContoller.text;
    if (_amountController.text.isEmpty) {
      return;
    }
    final _enteredAmount = double.parse(_amountController.text);

    if (_enteredTitle.isEmpty ||
        _enteredAmount <= 0 ||
        _transactionDate == null) {
      return;
    }
    widget._addTransactionHandler(
      _enteredTitle,
      _enteredAmount,
      _transactionDate,
    );
    Navigator.of(context).pop();
  }

  void _openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _transactionDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
              controller: _titleContoller,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount(Rs.)',
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _transactionDate != null
                        ? 'Picked Date : ${DateFormat.yMMMd().format(_transactionDate)}'
                        : 'No Date Selected',
                  ),
                  FlatButton(
                      onPressed: _openDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
            ),
            FlatButton(
              onPressed: () => _submitData,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.5,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
