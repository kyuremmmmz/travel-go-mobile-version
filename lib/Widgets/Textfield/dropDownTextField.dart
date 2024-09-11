import 'package:flutter/material.dart';

// ignore: camel_case_types
class dropDownTextField extends StatefulWidget {
  final String? text;
  final TextEditingController? controller;
  final Color? colorr;

  const dropDownTextField({
    super.key,
    required this.text,
    required this.controller,
    required this.colorr,
    required List<DropdownMenuItem<String>> items,
    required Null Function(dynamic value) onChanged,
  });

  @override
  State<DropdownButtonFormField> createState() => _dropDownTextField();
}

// ignore: camel_case_types
class _dropDownTextField extends State<DropdownButtonFormField> {
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
    return DropdownButtonFormField(
      decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          labelStyle: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(
                color: Colors.white,
              ))),
      focusNode: _focusNode,
      style: const TextStyle(
        fontSize: 12,
      ),
      items: const [],
      onChanged: (value) {},
    );
  }
}
