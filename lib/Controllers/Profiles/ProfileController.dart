import 'dart:ffi';
import 'dart:io';

import 'package:TravelGo/Routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    final response =
        await supabase.from('profiles').select('*').eq('id', name.toString());
    if (response.isNotEmpty) {
      final data = response;
      var img = data[0]['avatar_url'].toString();
      var imgUrl = await getter(img);
      data[0]['avatar_url'] = imgUrl;
      return data;
    }
    return [];
  }

  Future<PostgrestList> fetchUserWithoutgetter() async {
    user = supabase.auth.currentUser;
    late String? name = user?.id;
    final response =
        await supabase.from('profiles').select('*').eq('id', name.toString());
    if (response.isNotEmpty) {
      final data = response;
      var img = data[0]['avatar_url'].toString();
      data[0]['avatar_url'] = img;
      return data;
    }
    return [];
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
    final String originalName = image.name;

    final String uniqueName = '${DateTime.now().millisecondsSinceEpoch}_$originalName';

    try {
      final comments = await supabase
          .from('ratings_and_comments')
          .update({'avatar_url': uniqueName}).eq('comment_id', id);
      final storageResponse =
          await supabase.storage.from('avatars').upload(uniqueName, file);
      final response = await supabase
          .from('profiles')
          .upsert({'id': id, 'avatar_url': uniqueName});

      if (comments > 0) {
        return null;
      }
      if (storageResponse.isEmpty) {
        debugPrint('Error uploading image: $storageResponse');
        return null;
      }
      return response;
    } catch (e) {
      debugPrint('Exception occurred: $e');
      return null;
    }
  }

  Future<String?> fetchImageForComments(String name) async {
    
    final response = await supabase
        .from('profiles')
        .select('avatar_url')
        .eq('full_name', name)
        .single();
    if (response.isEmpty) {
      return null;
    } else {
      var data = response;
      var img = data['avatar_url'];
      var imgUrl = await getter(img);
      return imgUrl;
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
