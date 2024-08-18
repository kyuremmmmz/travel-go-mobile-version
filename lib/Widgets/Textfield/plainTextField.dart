import 'package:flutter/material.dart';

// ignore: camel_case_types
class plainTextField extends StatefulWidget {
  final String? text;

    const plainTextField
    ({
      super.key,
      required this.text,
    });

  @override
  State<plainTextField> createState() => _numberTextFieldState();
}


// ignore: camel_case_types
class _numberTextFieldState extends State<plainTextField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener((){
          if (!_focusNode.hasFocus) {
            FocusScope.of(context).unfocus();
          }
    });
  }

  @override
  void dispose(){
    _focusNode.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration:  InputDecoration(
          labelText: widget.text,
          labelStyle: const TextStyle(
            fontSize: 12,
          ),
          border: const UnderlineInputBorder(),
      ),
      focusNode: _focusNode,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
    );
  }
}