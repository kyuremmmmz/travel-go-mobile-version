// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types
class inputTextField extends StatefulWidget {
  final String? text;
  final TextEditingController? controller;
  final Color? colorr;
  final FormFieldValidator? validator;
  final Icon? icon;
  final Function? callback;

  const inputTextField({
    super.key,
    required this.text,
    required this.controller,
    required this.colorr,
    this.validator,
    this.icon,
    this.callback,
  });

  @override
  State<inputTextField> createState() => _numberTextFieldState();
}

// ignore: camel_case_types
class _numberTextFieldState extends State<inputTextField> {
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
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
          prefixIcon: widget.icon,
          labelText: widget.text,
          labelStyle: TextStyle(
            fontSize: 12.sp,
            color: Colors.black,
          ),
          floatingLabelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.white,
              ))),
      focusNode: _focusNode,
      style: TextStyle(fontSize: 12.sp, color: widget.colorr),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
