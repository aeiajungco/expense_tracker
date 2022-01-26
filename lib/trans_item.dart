// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'trans_var.dart';

class TransactionItems extends StatelessWidget {
  const TransactionItems({
    Key? key,
    required this.trans,
    required this.deleteTransaction,
  }) : super(key: key);
  

  final Transaction trans;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(7),
            child: FittedBox(child: Text('₱${trans.amount}')),
          ),
        ),
        title: Text(
          trans.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(DateFormat.yMMMd().format(trans.date)),
        trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteTransaction(trans.id),
                color: Colors.red,
              ),
      ),
    );
  }
}
