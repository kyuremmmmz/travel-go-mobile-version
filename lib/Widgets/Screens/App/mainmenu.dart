import 'package:flutter/material.dart';

import 'package:itransit/Widgets/Buttons/WithMethodButtons/BlueIconButton.dart';
import 'package:itransit/Widgets/Buttons/WithMethodButtons/PlaceButtonSquare.dart';

class Mainmenu extends StatefulWidget {
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food.png";
  final String hotelIcon = "assets/images/icon/hotel.png";

  final String hundredIsland = "assets/images/places/HundredIsland.jpeg";

  void main() {
    runApp(const Mainmenu());
  }

  const Mainmenu({super.key});
  @override
  State<Mainmenu> createState() => _MainmenuState();
}

class _MainmenuState extends State<Mainmenu> {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: 
        Padding(
          padding: const EdgeInsets.only(
            top: 50 
            ),
          child: Column(
            children: <Widget>[
              Container(
                child: const Column(
                  children: [
                        Text(
                    'TRAVEL GO',
                  ),
                  Text(
                    "Northwestern part of Luzon Island, Phillippines"
                  ),
                ],),
              ),
              
              //!-------------------<Scrollable Part(?) with Collapsable Widget>-----------------------!
              Expanded(
                child:
                Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(  
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: 
                    Column(children: <Widget>[
                      DismissableFindMoreLocation(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Categories', style: TextStyle(fontWeight: FontWeight.bold),),
                          GestureDetector(
                                onTap: () =>
                                    print("test"), // Add route or change this widget
                                child: const Text(
                                  'View all',
                                  style: TextStyle(color: Color.fromRGBO(33, 150, 243, 100), fontWeight: FontWeight.bold),
                                ),),
                        ],),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(children: [
                              BlueIconButtonDefault(image: widget.beachIcon, 
                              oppressed: ()=> print('test')
                              ),
                              CategoryLabel(label: 'Hotels'),
                            ],),
                            Column(children: [
                              BlueIconButtonDefault(image: widget.beachIcon, 
                              oppressed: ()=> print('test')
                              ),
                              CategoryLabel(label: 'Food Place'),
                            ],),
                            Column(children: [
                              BlueIconButtonDefault(image: widget.beachIcon, 
                              oppressed: ()=> print('test')
                              ),
                              CategoryLabel(label: 'Beaches'),
                            ],),
                            Column(children: [
                              BlueIconButtonDefault(image: widget.beachIcon, 
                              oppressed: ()=> print('test')
                              ),
                              CategoryLabel(label: 'Festivals and \nEvents'),
                            ],),
                        ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                      ],),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                      ],),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                      ],),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                      ],),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                      ],),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                          PlaceButtonSquare(
                            place: 'Hundred Island',
                            image: Image.asset(widget.hundredIsland).image, 
                            oppressed: () => print(''),),
                      ],),
                 ],)
              ),),),),
          ],),
      ),
    ),);
  }
}


// ignore: must_be_immutable
class CategoryLabel extends StatelessWidget{
  late String label;
  CategoryLabel({
    super.key, 
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        height: 50,
        child: Text(label, textAlign: TextAlign.center,)
      ));
  }
}

// Working in progress
class DismissableFindMoreLocation extends StatefulWidget{
  @override
  // ignore: library_private_types_in_public_api
  _DismissableFindMoreLocationState createState() => _DismissableFindMoreLocationState();
}

class _DismissableFindMoreLocationState extends State<DismissableFindMoreLocation>{
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return _isVisible
    ? Center(
      child:Container(
      height: 200,
      width: 380,
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Row (children: [
        Column(
          children: [
            Text('Test'),
            Text('Test')
        ],),
      ],)
    ,) ,) ): Container();
  }

}