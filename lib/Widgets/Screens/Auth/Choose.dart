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
  final LinearGradient gradient = 
    const LinearGradient(colors: [
      Colors.blueAccent,
      Color.fromARGB(255, 24, 24, 24)
    ],
    begin: Alignment.topCenter,
    end: Alignment.centerLeft
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: <Widget>[
            Positioned(
              top: -90,
              right: -20,
              left: -20,
              child: Align(
                child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(1), 
                  BlendMode.dstATop,),
                  child: Image.asset(
                    alignment: Alignment.center,
                    'assets/images/Background.png',
                    height: 450,
                    width: 400,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              height: 450,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                  top: 40
                  ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 8,
                      offset: const Offset(0, 10)
                    )
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60)
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                      right: 90
                    ),
                    child:   Column(
                      children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(
                            right: 20
                          ),
                          child: const Text(
                            'Welcome to',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          right: 60
                        ),
                        constraints: const BoxConstraints(
                          maxHeight: 200
                        ),
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            return gradient.createShader(
                              Rect.fromLTWH(0, 0, bounds.width, bounds.height)
                            );
                          },
                            child: const Text(
                              'TRAVEL GO',
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                    fontSize: 20,
                                      fontWeight: FontWeight.w900
                                    ),
                                    textAlign: TextAlign.left,
                                  )
                                ),
                              )
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 130,
                      ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 0,
                      ),
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 4)
                          )
                        ]
                      ),
                      width: 300,
                      height: 40,
                          child: Bluebottle(
                            color: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue
                              ),
                            text: const Text('Sign In',
                            style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ),
                        ),
                        const SizedBox(
                            height: 30,
                        ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 0,
                      ),
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 4)
                          )
                        ]
                      ),
                      width: 300,
                      height: 40,
                      child: Greenbutton(
                      text: const Text('Sign Up', 
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
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