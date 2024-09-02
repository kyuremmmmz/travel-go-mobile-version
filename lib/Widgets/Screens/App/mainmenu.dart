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
                  CategorySelect(label: "Categories", 
                  oppressed: ()=> print('')
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

                  CategorySelect(label: "Popular Places", 
                    oppressed: ()=> print('')
                    ),
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
                  CategorySelect(label: "Food Places", 
                    oppressed: ()=> print('')
                    ),
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
                  CategorySelect(label: "Festival and Events", 
                    oppressed: ()=> print('')
                    ),
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
// Class for the removable section
class DismissableFindMoreLocation extends StatefulWidget{
  final String xButtonIcon = "assets/images/icon/ButtonX.png";
  final String adventureIcon = "assets/images/icon/adventure.png";

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
      height: 180,
      width: 380,
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Column(children: <Widget>[
        Row (children: [
        const Expanded(
          flex: 2,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Text('Find more location \naround you',
              style: TextStyle(fontSize: 20),
             ),),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text('Find your next adventure around Pangasinan \nand create unforgettable memories!',
              style: TextStyle(fontSize: 10),
            ),),
        ],),),
        SizedBox(
          height: 180,
          width: 100,
          child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child:  IconButton(
              iconSize: 20,
              icon: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset(widget.xButtonIcon),
              ),
              onPressed: ()=> {
                setState(() {_isVisible = false;}
                ),
              },
            ),),
           
            Positioned(
              
              child: SizedBox(
              height: 80,
              width: 80,
              child: Image.asset(widget.adventureIcon),
            ))
        ],),)
        ],),
      ],),)) : Container();
  }
}

class CategorySelect extends StatelessWidget{
  final String label;
  final VoidCallback oppressed;

  CategorySelect({
    required this.label,
    required this.oppressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold),),
            GestureDetector(
            onTap: oppressed,
            child: const Text(
            'View all',
            style: TextStyle(color: Color.fromRGBO(33, 150, 243, 100), fontWeight: FontWeight.bold),
          ),),
        ],),
        const SizedBox(
          height: 20,
        )
      ],);
  }
}