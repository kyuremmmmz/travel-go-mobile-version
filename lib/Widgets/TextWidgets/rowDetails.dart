import 'package:flutter/material.dart';

class RowDetails extends StatelessWidget{
  String row1, row2;
  RowDetails({
    required this.row1, 
    required this.row2,
  });

  @override
  Widget build(BuildContext context) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          row1,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
        Text(
          row2,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
            color: Color.fromRGBO(5, 103, 180, 1),
          ),
        ),
      ],
    );
  }
}