// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';
import 'trans_var.dart';

class Chart extends StatelessWidget {
  final List<Transaction> weeklyTrans;

  Chart(this.weeklyTrans);

  List<Map<String, Object>> get groupTransVal {
    return List.generate(7, (index) {
      final weekdays = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      double totalSum = 0;

      for (int i = 0; i < weeklyTrans.length; i++) {
        if (weeklyTrans[i].date.day == weekdays.day && weeklyTrans[i].date.month == weekdays.month && weeklyTrans[i].date.year == weekdays.year) {
          totalSum += weeklyTrans[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekdays).substring(0, 3),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpendings {
    return groupTransVal.fold(0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 5,
          ),
        ],
      ),
      height: 0,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupTransVal.map((data) {
            return ChartBar(
              (data['day'] as String),
              (data['amount'] as double),
              totalSpendings == 0.0
                  ? 0.0
                  : ((data['amount'] as double) / totalSpendings),
            );
          }).toList(),
        ),
      ),
    );
  }
}
