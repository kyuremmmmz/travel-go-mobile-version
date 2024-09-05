import 'package:flutter/material.dart';

// ignore: camel_case_types, must_be_immutable
class checkBoxFormField extends StatefulWidget {
  final String labelText;
  final bool isChecked;
  String error;
  final void Function(bool?) onChanged;

  checkBoxFormField({
    super.key,
    required this.labelText,
    required this.isChecked,
    required this.onChanged,
    required FormFieldValidator<bool>? validator,
    required this.error,
  });

  @override
  State<checkBoxFormField> createState() => _numberTextFieldState();
}

// ignore: camel_case_types
class _numberTextFieldState extends State<checkBoxFormField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: false,
      onChanged: (bool? value) {},
    );
  }
}
