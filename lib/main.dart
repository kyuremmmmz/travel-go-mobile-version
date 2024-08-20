import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Widgets/Buttons/WithMethodButtons/BlueButton.dart';
import 'Widgets/Buttons/WithMethodButtons/GreenButton.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}


class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel go',
      debugShowCheckedModeBanner: false,
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

const url1 = 'https://cdfmtahwfxugtjaplfjt.supabase.co';
const apikey1 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNkZm10YWh3Znh1Z3RqYXBsZmp0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQxNDA4NTQsImV4cCI6MjAzOTcxNjg1NH0.t2RxCaEhF3yAuuf2Chug2uGz6Vf_VND1AuoO9wqU_8s';
// ignore: camel_case_types

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: url1,
    anonKey: apikey1,
  );
  

  runApp(const WelcomePage());
}