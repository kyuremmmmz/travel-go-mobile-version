import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BlueIconButtonDefault extends StatefulWidget{

  late String image; // use the location of image
  late VoidCallback oppressed;
  BlueIconButtonDefault
  ({
    super.key,
    required this.image,
    required this.oppressed,
  });
  @override
  State<StatefulWidget> createState() => _BlueButtonWithoutFunctionState();
}

class _BlueButtonWithoutFunctionState extends State<BlueIconButtonDefault> {
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 75,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(222, 239, 252, 100),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: InkWell (
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          onTap: widget.oppressed,
          child: 
            Padding(
              padding: const EdgeInsets.all(10),
              child: 
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Image.asset(widget.image),
                  )
                ),
        )
      ),
    );
  }

}