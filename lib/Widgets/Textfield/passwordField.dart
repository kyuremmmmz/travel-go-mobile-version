import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types
class passwordTextField extends StatefulWidget {
  final String? text;
  final TextEditingController? password;
  final dynamic validator;

  const passwordTextField({
    super.key,
    required this.text,
    required this.password,
    required this.validator,
    required TextEditingController controller,
  });

  @override
  State<passwordTextField> createState() => _numberTextFieldState();
}

// ignore: camel_case_types
class _numberTextFieldState extends State<passwordTextField> {
  // ignore: non_constant_identifier_names
  bool _IsObsucure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.password,
      validator: widget.validator,
      decoration: InputDecoration(
          labelText: widget.text,
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _IsObsucure = !_IsObsucure;
                });
              },
              icon: Icon(_IsObsucure ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black, size: 25.sp)),
          labelStyle: TextStyle(fontSize: 15.sp, color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black))),
      style: TextStyle(fontSize: 15.sp, color: Colors.black),
      obscureText: _IsObsucure,
    );
  }
}
