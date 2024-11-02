import 'dart:ffi'; // Foreign function interface library 
import 'dart:io'; // file handling

import 'package:TravelGo/Routes/Routes.dart'; // importing routes dor navigation
import 'package:flutter/material.dart'; // flutter material design library 
import 'package:image_picker/image_picker.dart'; // image picker library 
import 'package:supabase_flutter/supabase_flutter.dart'; // importing supabase for flutter 

class Usersss {
  late User? user; // varibale to hold the current user 
  late Bool send; // variable indicating whether a verification code has been sent 
  SupabaseClient supabase = Supabase.instance.client;

  // Method to sign out the current user
  Future<void> signout(BuildContext context) async {
    Future.delayed(Duration.zero); // Delays for any pending tasks 
    await supabase.auth.signOut(); // Signs out the user
  }

  // Method to fetch the current user's profile 
  Future<PostgrestList> fetchUser() async {
    user = supabase.auth.currentUser; // this get the current authent8icated user 
    late String? name = user?.id; // get the user's ID 
    final response =
        await supabase.from('profiles').select('*').eq('id', name.toString());
    if (response.isNotEmpty) {
      final data = response; // Store the response data
      var img = data[0]['avatar_url'].toString(); // get the avatar URL 
      var imgUrl = await getter(img); // fetch the public URL for the img
      data[0]['avatar_url'] = imgUrl; // update the avatr URL in the data 
      return data;
    }
    return []; // Return user profile data
  }

  // Method to fetch user profile without modifying the avatar URL
  Future<PostgrestList> fetchUserWithoutgetter() async {
    user = supabase.auth.currentUser;
    late String? name = user?.id;
    final response =
        await supabase.from('profiles').select('*').eq('id', name.toString());
    if (response.isNotEmpty) {
      final data = response;
      var img = data[0]['avatar_url'].toString();
      data[0]['avatar_url'] = img;  // Keep the avatar URL unchanged in the data
      return data;  // Return user profile data
    }
    return []; // Return an empty list if no data is found
  }

  // Method to send a verification code to the user's email
  Future<dynamic> sendVerificationCode(
      String? email, BuildContext context) async {
    try {
      await supabase.auth.resetPasswordForEmail(email!); // this send the reset passsword email

      // ignore: use_build_context_synchronously
      AppRoutes.navigateToEmailScreen(context); // navigate to email screen 
    } catch (e) {
      if (email.toString().isEmpty) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill your email'))); // this show error message
      }
    }
  }

  // Method to reset the user's password using a verification token
  Future<dynamic> resetPasssword(
      String? token, String? email, String? password) async {
    try {
      await supabase.auth
          .verifyOTP(email: email, token: token, type: OtpType.recovery); // Verify OTP for password reset 

      await supabase.auth.updateUser(UserAttributes(password: password)); // this update the user's password 
      const SnackBar(content: Text('Password reset successfully')); // show success message 
    } catch (e) {
      SnackBar(content: Text('error: $e')); // thi handle any error
    }
  }

  // Method to edit the user's profile by uploading a new avatar
  Future<String?> editProfile(String id) async {
    final ImagePicker picker = ImagePicker(); // Create an instance of ImagePicker
    final XFile? image = await picker.pickImage(source: ImageSource.gallery); // pick an image from the gallery 
    if (image == null) {
      debugPrint('null'); // log if no image was selected 
      return 'null'; // return 'nukk' if no image was selected 
    }
    File file = File(image.path);
    final String originalName = image.name;

    final String uniqueName =
        '${DateTime.now().millisecondsSinceEpoch}_$originalName'; // Generate a unique name for the image

    try {
      final comments = await supabase
          .from('ratings_and_comments')
          .update({'avatar_url': uniqueName}).eq('comment_id', id); // Update the avatar URL in comment
      final storageResponse =
          await supabase.storage.from('avatars').upload(uniqueName, file); // Upload the image to storage
      final response = await supabase
          .from('profiles')
          .upsert({'id': id, 'avatar_url': uniqueName}); // Update or insert the user's profile with the new avatar URL

      if (comments > 0) {
        return null; // Return null if comments were updated successfully
      }
      if (storageResponse.isEmpty) {
        debugPrint('Error uploading image: $storageResponse'); // Log error if image upload failed
        return null; // Return null if there was an error
      }
      return response; // Return the response from the profile update
    } catch (e) {
      debugPrint('Exception occurred: $e'); // Log any exceptions
      return null; // Return null on error
    }
  }


  // Method to fetch the public URL of an avatar image
  Future<String?> getter(String name) async {
    final img = supabase.storage.from('avatars').getPublicUrl(name); // Get public URL of the image
    if (img.isEmpty) {
      return null;
    } else {
      return img; // Return the public URL of the image
    }
  }
}
