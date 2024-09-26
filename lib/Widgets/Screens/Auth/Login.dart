import 'package:flutter/material.dart'; // Import thr material design widgets 
import 'package:itransit/Controllers/Auth/login.dart'; // Import login logic 
import 'package:itransit/Widgets/Textfield/passwordField.dart'; // import passowrd widget
import 'package:itransit/Routes/Routes.dart'; // Import routes for navigation 
import '../../Textfield/plainTextField.dart'; //Import plain text widget
import './../../Buttons/DefaultButtons/BlueButton.dart'; // Import custom blue button widget

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure proper initialization before running the app 
  runApp(const Loginscreen()); // this run the loginscreen widget 
}

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});  // Constructor for Loginscreen

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Travel Go Pangasinan',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), // Set LoginScreen as the home widget
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key}); // Constructor for LoginScreen

  @override
  State<LoginScreen> createState() => _LoginScreenState(); // Create the state for LoginScreen
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(); // Controller for the email text field
  final _passwordController = TextEditingController(); // Controller for the password text field

  @override
  void dispose() {
    // the dispose of the controllers when the widget is removed from the tree
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState(); // Initialize any state when the widget is first created
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      resizeToAvoidBottomInset: false, // this avoid resizing the body when the keyboard appears
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
                  fit: BoxFit.cover, // Cover the whole container with the image
                  height: 470,
                  width: 500,
                ),
              ),
              Container(
                height: 470,
                width: 500,
                color: Colors.black.withOpacity(0.5), // Semi-transparent black overlay
              )
            ]),
          ),
          const Positioned(
            top: 100,
            right: 95,
            child: Text(
              textAlign: TextAlign.center,
              'TRAVEL GO', // the logo area 
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
            ),
          ),
          const Positioned(
              top: 150,
              right: 20,
              child: Text(
                'Travel and get more experience here in Pangasinan!', // the caption area next the trevel go text
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15),
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
                      width: 400,
                      padding: const EdgeInsets.only(top: 0),
                      child: plainTextField(
                        colorr: Colors.black,
                        text: 'Email',
                        controller: _emailController,
                      ),
                    ),
                    const SizedBox(
                      height: 30, // Space between the email and password fields
                    ),
                    SizedBox(
                      width: 400,
                      child: passwordTextField(
                        text: 'Password', // Placeholder text for the password field
                        password: _passwordController, // Controller for the password field
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20, left: 280),
                      child: GestureDetector(
                        onTap: () =>
                            {AppRoutes.navigateToForgotPassword(context)}, // Navigate to the forgot password screen
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(fontSize: 15, color: Colors.grey), // Style for the forgot password text
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 70, // Space above the sign-in button
                    ),
                    Container(
                        padding: null,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),  // Rounded corners for the button
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
                            style: TextStyle(color: Colors.white, fontSize: 20), // Style for the button text
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
                                .loginUser(context); // Call the login function
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
