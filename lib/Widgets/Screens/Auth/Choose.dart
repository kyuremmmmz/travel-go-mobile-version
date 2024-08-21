import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Buttons/WithMethodButtons/BlueButton.dart';
import 'package:itransit/Widgets/Buttons/WithMethodButtons/GreenButton.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Welcomepage());
}

class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome Page',
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}


class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel go',
      home: Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: <Widget>[
          Padding(
                padding: const EdgeInsets.only(
                  top: 100
                ),
                child: Container(
                alignment: Alignment.bottomCenter,
                width: 500,
                height: 150,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(221, 0, 0, 0),
                  shape: BoxShape.circle
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Travel Go',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Pangasinan',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              ),
            ),
            const Padding( 
              padding: EdgeInsets.only(
                top: 10
              ),
              child: Text(
                'Travel Go Pangasinan',
                textAlign: TextAlign.center,              
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                top: 200
              ),
              child: Column(
                children: <Widget>[
                  Bluebottle(
                    color: Colors.blue, 
                    text: 'Log in'
                  ),
                  const Text(
                    'or'
                  ),
                  Greenbutton(
                    text: 'Create Account', 
                    color: Colors.green
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