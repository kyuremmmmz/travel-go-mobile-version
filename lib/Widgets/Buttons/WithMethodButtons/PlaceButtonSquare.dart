import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PlaceButtonSquare extends StatefulWidget{
  late ImageProvider image; // use Image.asset
  late VoidCallback oppressed;
  late String place;
  PlaceButtonSquare
  ({
    super.key,
    required this.place,
    required this.image,
    required this.oppressed,
  });
  @override
  State<StatefulWidget> createState() => _PlaceButtonSquareState();
}

class _PlaceButtonSquareState extends State<PlaceButtonSquare> {

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Material(
      child: Ink.image(
        fit: BoxFit.fill,
        width: 110,
        height: 110,
        image: widget.image,
        child: InkWell(
          onTap: widget.oppressed,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(widget.place, 
              style: const TextStyle(
                color: Colors.white,
              ),)
            ),
          )
        )
      ),),
    );
  }
}