import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VoucherButton extends StatefulWidget{
  late ImageProvider image; // use Image.asset
  late VoidCallback oppressed;
  late String voucherTitle;
  late String description;
  late String expiring;
  VoucherButton
  ({
    super.key,
    required this.voucherTitle,
    required this.description,
    required this.expiring,
    required this.image,
    required this.oppressed,
  });
  @override
  State<StatefulWidget> createState() => _VoucherButtonState();
}

class _VoucherButtonState extends State<VoucherButton> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.oppressed,
      child: 
        Container(
        width: 280,
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromRGBO(194,228,231,100),
          border: Border.all(color: Colors.black,),
          borderRadius: BorderRadius.circular(10),  
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color.fromARGB(255, 175, 175, 175), width: 0.5),
                borderRadius: BorderRadius.circular(10),  
              ),
              child: 
                Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Image(image: widget.image,),
                  )
                ],
              ),
            ),
            
            Container(
              padding: const EdgeInsets.all(5),
              width: 258,
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.voucherTitle,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.description,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color.fromRGBO(5, 103, 180, 100),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Expiring: ',
                        style: TextStyle(
                          fontSize: 9
                        ),
                      ),
                      Text(
                        widget.expiring,
                        style: const TextStyle(
                          fontSize: 9
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}