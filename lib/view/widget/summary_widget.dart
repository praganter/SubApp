import 'package:flutter/material.dart';

class SummaryRow extends StatelessWidget {
  String title = "";
  int amount = 0;
  SummaryRow({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title),
          Text(amount.toString()),
        ],
      ),
    );
  }
}
