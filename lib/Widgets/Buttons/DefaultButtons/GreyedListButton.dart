import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GreyedButton extends StatefulWidget {
  late String image; // use the location of image
  GreyedButton({
    super.key,
    required this.image,
  });
  @override
  State<StatefulWidget> createState() => _GreyedButtonState();
}

class _GreyedButtonState extends State<GreyedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 75,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(190, 190, 190, 0.612),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Image.asset(widget.image),
            )),
      ),
    );
  }
}
