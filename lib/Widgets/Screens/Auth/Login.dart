import 'package:flutter/material.dart';
void main(){
  runApp(const LoginScreen());
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 40
            ),
            child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                  maxWidth: 359,
                  minHeight: 100,
                  minWidth: 200
                ),
                height: 300,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      100
                    )
                  ),
                  color: Colors.blue,
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 100,
                  ),
                  margin: const EdgeInsets.only(
                    left: 10
                  ),
                  child: const Text(
                  'TRAVEL AND GET MORE EXPERIENCE IN BALUNGAO PANGASINAN!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}