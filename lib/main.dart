// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'trans_list.dart';
import 'trans_var.dart';
import 'trans_form.dart';
import 'chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(primarySwatch: Colors.purple, fontFamily: 'Quicksand'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];

  void addTransaction(String txtitle, double amount, DateTime selectedDate) {
    final newTrans = Transaction(
      title: txtitle,
      amount: amount,
      id: DateTime.now().toString(),
      date: selectedDate,
    );

    setState(() {
      transactions.add(newTrans);
    });
  }

  void delTransaction(String transID) {
    setState(() {
      transactions.removeWhere((index) => (index.id == transID));
    });
  }

  void fillTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return TransactionForm(addTransaction);
      },
    );
  }

  List<Transaction> get recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final dynamic appBar = AppBar(
      title: Text(
        'Expense Tracker',
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () => fillTransaction(context), icon: Icon(Icons.add)),
      ],
    );

    return Scaffold(
      appBar: appBar,
      // body: pageBody,
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Chart(recentTransactions),
          ),
          SizedBox(
              height: 570, child: Transactionlist(transactions, delTransaction))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => fillTransaction(context),
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black),
    );
  }
}
