// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, unnecessary_string_interpolations

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendAmount;
  final double percentage;

  ChartBar(this.label, this.spendAmount, this.percentage);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 25,
          child: FittedBox(
            child: Text('₱${spendAmount.toStringAsFixed(0)}', style: TextStyle(fontSize: 10),),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 70,
          width: 14,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.5),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 20,
          child: FittedBox(
            child: Text('$label', style: TextStyle(fontFamily: 'OpenSans'),),
          ),
        ),
      ],
    );
  }
}
