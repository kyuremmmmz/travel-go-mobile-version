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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: <Widget>[
            Positioned.fill(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/Background.png'
                  ),
                )
              ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              height: 450,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                  top: 300
                  ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)
                  )
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
                    SizedBox(
                      width: 300,
                      child: Greenbutton(
                      text: 'Sign Up', 
                      color: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey.shade100,
                        )
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
  }
}