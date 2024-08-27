import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Textfield/passwordField.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../Controllers/Supabase/key.dart';
import '../../Textfield/plainTextField.dart';
import './../../Buttons/DefaultButtons/BlueButton.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const signupScreen());
}

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sign up Screen',
      home: signupScreen(),
    );
  }
}
// ignore: camel_case_types
class signupScreen extends StatefulWidget {
  const signupScreen({super.key});

  @override
  State<signupScreen> createState() => _signupScreenState();
}

// ignore: camel_case_types
class _signupScreenState extends State<signupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  SingleChildScrollView(
        padding: const EdgeInsets.only(
          bottom: 100,
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 30
            ),
            child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                  maxWidth: 359,
                  minHeight: 100,
                  minWidth: 200
                ),
                height: 220,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      130
                    )
                  ),
                  color: Colors.blue,
                  
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 80,
                  ),
                  margin: const EdgeInsets.only(
                    left: 30
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
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 30
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
                'Sign Up',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 31, 31, 31),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
              ),
              oppressed:  () async{
                try {
                  final database db = database();
                  final supa = db.superbase;
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();

                  final AuthResponse result = await supa.auth.signUp(
                    password: password, 
                    email: email,
                  );

                  final User? user = result.user;
                  if (mounted) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Welcome $user')),
                    );
                  }
                } catch (e) {
                  print(e);
                }
              }
            ),
          )
        ],
      ),
    )
  );
}
}
