import 'package:flutter/material.dart';

class Trgowithdraw extends StatefulWidget {
  const Trgowithdraw({super.key});

  @override
  State<Trgowithdraw> createState() => _TrgowithdrawState();
}

class _TrgowithdrawState extends State<Trgowithdraw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRGOYALTY WALLET'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              child: const Text(
                'YOUR TRGOYALTY POINTS '
                , 
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 48, 47, 47),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            
            Container(
              child: Row(
                children: [
                  const SizedBox(
                    width: 150,
                  ),
                  Container(
                    child: Text('1260'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Text('points'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}