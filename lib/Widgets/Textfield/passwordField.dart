import 'package:flutter/material.dart';

// ignore: camel_case_types
class passwordTextField extends StatefulWidget {
  final String? text;
  final TextEditingController? password;
    const passwordTextField
    ({
      super.key,
      required this.text,
      required this.password,
    });

  @override
  State<passwordTextField> createState() => _numberTextFieldState();
}


// ignore: camel_case_types
class _numberTextFieldState extends State<passwordTextField> {
  final TextEditingController _controller = TextEditingController();
  // ignore: non_constant_identifier_names
  bool _IsObsucure = true;

  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration:  InputDecoration(
          labelText: widget.text,
          suffixIcon: IconButton(
            onPressed: (){
              setState(() {
                _IsObsucure = !_IsObsucure;
              });
            },
            icon: Icon(
              _IsObsucure ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            )
            ),
          labelStyle: const TextStyle(
            fontSize: 12
          ),
          border: const UnderlineInputBorder(),
      ),
      style: const TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
      obscureText: _IsObsucure,
    );
  }
}