import 'package:flutter/material.dart';
import 'package:itransit/Controllers/Auth/login.dart';
import 'package:itransit/Widgets/Textfield/passwordField.dart';

import '../../Textfield/plainTextField.dart';
import './../../Buttons/DefaultButtons/BlueButton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Loginscreen());
}

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Travel Go Pangasinan',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -85,
            right: -30,
            left: -30,
            child: Stack(children: [
              Align(
                child: Image.asset(
                  'assets/images/Background.png',
                  fit: BoxFit.cover,
                  height: 470,
                  width: 500,
                ),
              ),
              Container(
                height: 470,
                width: 500,
                color: Colors.black.withOpacity(0.3),
              )
            ]),
          ),
          const Positioned(
              top: 100,
              right: 95,
              child: Text(
                textAlign: TextAlign.center,
                'TRAVEL GO',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(5.0, 5.0), // Shadow position
                        blurRadius: 12.0,
                        color: Colors.black,
                      )
                    ]),
              )),
          Positioned(
            bottom: -320,
            right: 0,
            left: 0,
            height: 800,
            child: Container(
              padding: const EdgeInsets.only(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0,
              ),
              decoration: const BoxDecoration(color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 500,
                      padding: const EdgeInsets.only(top: 0),
                      child: plainTextField(
                        text: 'Email',
                        controller: _emailController,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    passwordTextField(
                      text: 'Password',
                      password: _passwordController,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20, left: 250),
                      child: GestureDetector(
                        onTap: () => {print('ewan basta pinindot ko')},
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Container(
                        padding: null,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 5),
                              )
                            ]),
                        child: BlueButtonWithoutFunction(
                          text: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 26, 219, 245),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          oppressed: () async {
                            Login(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim())
                                .loginUser(context);
                          },
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
