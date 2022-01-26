
// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {

  final Function addTrans;

  TransactionForm(this.addTrans);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final title = TextEditingController();
  final amount = TextEditingController();

  DateTime selectedDate = DateTime(2020);

  void _onSubmit() {
    final transTitle = title.text;
    final transAmount = double.parse(amount.text);

    if (transTitle.isEmpty || transAmount <= 0 || selectedDate == DateTime(2020)) {
      return;
    }

    widget.addTrans(transTitle, transAmount, selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((chosenDate) {
      if (chosenDate == null) {
        return;
      }
      setState(() {
        selectedDate = chosenDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                cursorColor: Colors.green,
                enableInteractiveSelection: true,
                controller: title,

                onSubmitted: (_) => _onSubmit(),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amount,

                onSubmitted: (_) => _onSubmit(),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedDate == DateTime(2018)
                            ? 'No Date Chosen'
                            : 'Picked Date: ${DateFormat.yMd().format(selectedDate)}',
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: _presentDate,
                      child: Text(
                        'Choose date',
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _onSubmit,
                    child: Text(
                      'Add Transaction',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.purple,
                      maximumSize: Size(115, 50),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
