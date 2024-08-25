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
          Container(
            height: 12,
            padding: const EdgeInsets.only(
              top: 500
            ),
          ),
            Container(
              height: 20,
              color: Colors.amber,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                top: 300
              ),
              padding: const EdgeInsets.only(
                
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: 300,
                        child: Bluebottle(
                          color: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade400
                            ),
                          text: const Text('Log in',
                          style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ),
                      ),
                  const Text(
                    'or'
                  ),
                  Greenbutton(
                    text: 'Create Account', 
                    color: const Color.fromARGB(255, 226, 222, 222)
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