// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final TextEditingController controller;
  final InputDecoration style;
  const Search({
    super.key,
    required this.controller,
    required this.style,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: widget.style,
    );
  }
}
