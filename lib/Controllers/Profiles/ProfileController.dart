import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Usersss {
  late User? user;
  late Bool send;
  SupabaseClient supabase = Supabase.instance.client;

  Future<void> signout(BuildContext context) async {
    Future.delayed(Duration.zero);
    await supabase.auth.signOut();
  }

  Future<PostgrestList> fetchUser() async {
    user = supabase.auth.currentUser;
    late String? name = user?.id;
    return await supabase
        .from('profiles')
        .select('*')
        .eq('id', name.toString());
  }

  Future<dynamic> sendVerificationCode(
      String? email, BuildContext context) async {
    try {
      await supabase.auth.resetPasswordForEmail(email!);

      // ignore: use_build_context_synchronously
      AppRoutes.navigateToEmailScreen(context);
    } catch (e) {
      if (email.toString().isEmpty) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill your email')));
      }
    }
  }

  Future<dynamic> resetPasssword(
      String? token, String? email, String? password) async {
    try {
      await supabase.auth
          .verifyOTP(email: email, token: token, type: OtpType.recovery);

      await supabase.auth.updateUser(UserAttributes(password: password));
      const SnackBar(content: Text('Password reset successfully'));
    } catch (e) {
      SnackBar(content: Text('error: $e'));
    }
  }

  Future<String?> editProfile(String id) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      debugPrint('null');
      return 'null';
    }
    File file = File(image.path);
    final String name = 'user_${DateTime.now().microsecondsSinceEpoch}.jpg';

    try {
      final storageResponse =
          await supabase.storage.from('avatars').upload(name, file);

      if (storageResponse.isNotEmpty) {
        debugPrint('Error uploading image: $storageResponse');
        return null;
      }

      final response = await supabase.from('profiles').upsert(
          {'id': id, 'avatar_url': storageResponse});

      return response.data;
    } catch (e) {
      debugPrint('Exception occurred: $e');
      return null;
    }
  }

  Future<String?> getter(String name) async {
    final img = supabase.storage.from('avatars').getPublicUrl(name);
    if (img.isEmpty) {
      return null;
    } else {
      return img;
    }
  }
}
