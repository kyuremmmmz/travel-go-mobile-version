import 'package:flutter/material.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Widgets/Buttons/DefaultButtons/RedButton.dart';
class Home extends StatefulWidget {
  void main(){
    runApp(const Home());
  }
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: const Text('Welcome user!'),
              ),
              Container(
                  padding: const EdgeInsets.only(
                    top:0,
                  ),
                  child: RedButton(
                    callbackAction: (){
                      Usersss().signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red
                    ),
                    text: const Text('LOG OUT')
                ),
              )
            ],
          ),
          ),
        );
  }
}