import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types
class plainTextField extends StatefulWidget {
  final String? text;
  final TextEditingController? controller;
  final Color? colorr;
  final dynamic validator;

  const plainTextField({
    super.key,
    required this.text,
    required this.controller,
    required this.colorr,
    required this.validator,
  });

  @override
  State<plainTextField> createState() => _numberTextFieldState();
}

// ignore: camel_case_types
class _numberTextFieldState extends State<plainTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
          labelText: widget.text,
          floatingLabelStyle: TextStyle(color: widget.colorr),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
          labelStyle: TextStyle(fontSize: 15.sp, color: Colors.black),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black,
          ))),
      style: TextStyle(fontSize: 16.sp, color: widget.colorr),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
