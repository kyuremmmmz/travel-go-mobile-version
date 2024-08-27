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
      title: 'Loginscreen',
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
  final Login state = Login(email: '', password: '');

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
      body: Stack(
            children: <Widget> [
              
            Container(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: Column(
                children: [
                  plainTextField(
                    text: 'Enter your email address',
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  passwordTextField(
                    text: 'Enter your password',
                    password: _passwordController,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              width: 400,
              child: BlueButtonWithoutFunction(
                text: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white
                    ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 31, 31, 31),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                oppressed: () async {
                  Login(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim())
                        .loginUser(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        }
