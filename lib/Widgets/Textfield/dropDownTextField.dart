// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    required Null Function(dynamic val) onChanged,
  });

  @override
  State<dropDownTextField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<dropDownTextField> {
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
    var vehicleList = ["Tricycle", "Motorcycle", "Bus/Van", "Airplane"];
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: widget.text,
          alignLabelWithHint: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          labelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.white,
              ))),
      focusNode: _focusNode,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
      onChanged: (String? val) {
        setState(() {});
      },
      items: vehicleList.map<DropdownMenuItem<String>>((String vehicles) {
        return DropdownMenuItem<String>(
          value: vehicles,
          child: Text(vehicles),
        );
      }).toList(),
    );
  }
}
