import 'package:flutter/material.dart';

class RedButton extends StatefulWidget {
  final VoidCallback callbackAction;
  final ButtonStyle style;
  final Text text;

  const RedButton
  ({
    super.key, 
    required this.callbackAction,
    required this.style,
    required this.text,
  });

  @override
  State<RedButton> createState() => _RedButtonState();
}

class _RedButtonState extends State<RedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton
    (
      onPressed: widget.callbackAction, 
      child: widget.text,
      style: widget.style,
    );
  }
}