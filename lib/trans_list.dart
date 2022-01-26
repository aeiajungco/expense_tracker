// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:ui';

import 'package:flutter/material.dart';

import 'trans_item.dart';
import 'trans_var.dart';

class Transactionlist extends StatelessWidget {
  final List<Transaction> trans;
  final Function deleteTransaction;

  Transactionlist(this.trans, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        child: trans.isEmpty
            ? LayoutBuilder(
                builder: (ctx, constraints) {
                  return Column(
                    children: [
                      Text(
                        'No transactions added yet!',
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        height: 300,
                        width: 130,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/waiting.png',),
                              colorFilter: ColorFilter.mode(
                                  Colors.white.withOpacity(0.4),
                                  BlendMode.dstATop),
                              fit: BoxFit.cover,
                            ),
                            color: Colors.transparent),
                      )
                    ],
                  );
                },
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return TransactionItems(
                      trans: trans[index],
                      deleteTransaction: deleteTransaction);
                },
                itemCount: trans.length,
              ),
      );
    });
  }
}
