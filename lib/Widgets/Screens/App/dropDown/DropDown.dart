// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  const DropDown({
    super.key,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? selectedOption = 'Payment Method';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      onChanged: (String? value) {
        setState(() {
          selectedOption = value!;
        });
      },
      items: [
        DropdownMenuItem(value: widget.option1, child: Text(widget.option1)),
        DropdownMenuItem(value: widget.option2, child: Text(widget.option2)),
        DropdownMenuItem(value: widget.option3, child: Text(widget.option3)),
      ],
    );
  }
}
