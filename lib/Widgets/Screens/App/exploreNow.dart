import 'package:flutter/material.dart';

class Explorenow extends StatefulWidget {
  const Explorenow({super.key});

  @override
  State<Explorenow> createState() => _ExplorenowState();
}

class _ExplorenowState extends State<Explorenow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              child: Container(
            child: Column(
              children: [
                Container(
                  child: Container(),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
