import 'package:flutter/foundation.dart'; // provides core functionalities for Flutter, including error handling and async tools
import 'package:flutter/material.dart'; // Package for UI components
import 'package:supabase_flutter/supabase_flutter.dart'; // Import supabase flutter SDK for bwackend functionality
//JUST A TEST MUNA ITONG JSON

// Class to handle user signup
class Signup {
  late final String? fullName; // Store user's full name
  late final int? phoneNumber; // all of these is storage
  late final String? username;
  late final String? email;
  late final String? password;
  late final Text error;

  Signup({
    // Constructor to initialize signup with optional paramenters.
    this.email,
    this.fullName,
    this.password,
    this.phoneNumber,
    this.username,
  });

  bool validator(String email) {
    // method to validate email format using regex
    String pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'; // the regex (regular expression) pattern for validating email format
    RegExp r = RegExp(pattern); // create Regex object
    return r.hasMatch(email); // this Check if email matches pattern
  }

  Future<String> sign(BuildContext context, String val) async {
    // async method to handle signup logic
    final supabase = Supabase.instance.client; // get supabase client
    try {
      if (val.isEmpty) {
        // this check if the email input is empty
        return 'please enter an email'; // this return the error message
      }
      if (!validator(email ?? '')) {
        return 'Invalid email'; // this return if the email is invaliid
      } else {
        await supabase.auth.signUp(
            // this attempt to sign up the user with supabase
            email: email, // use provided email
            password: password ?? '', // the provided password of user
            emailRedirectTo: kIsWeb // this handle redirect for web and mobile
                ? null
                : "io.supabase.flutterquickstart://login-callback/",
            data: {
              // this was the additional user data
              'full_name': fullName,
              'phone_number': phoneNumber,
              'username': username
            });
        await supabase.from('TRGO_POINTS').insert({
          'points' : 0.10,
          'user_id': supabase.auth.currentUser!.id,
          'withdrawablePoints' : 0.0,
          'placeholder' : 0.0
        });
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          // this show success message in a snackbar
          content: Text('Signed up Successfully check your email')));
      // ignore: empty_catches
    } catch (error) {
      // this handle error during signup
      ScaffoldMessenger
              // ignore: use_build_context_synchronously
              .of(context)
          .showSnackBar(
        SnackBar(
          content: Text('Error: $error'), // the displapy error message
        ),
      );
      print(error);
    }
    return 'Success';
  }
}
