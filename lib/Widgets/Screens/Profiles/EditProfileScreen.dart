import 'package:TravelGo/Routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  final String? currentName;
  final String? currentEmail;
  final String? currentAvatarUrl;

  const EditProfileScreen({
    super.key,
    this.currentName,
    this.currentEmail,
    this.currentAvatarUrl,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String? _avatarUrl;
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentName ?? '';
    _emailController.text = widget.currentEmail ?? '';
    _avatarUrl = widget.currentAvatarUrl;
  }

  Future<void> _updateProfile() async {
    final userId = Supabase.instance.client.auth.currentUser!.id;
    await supabase
        .from('profiles')
        .update({'full_name': _nameController.text}).eq('id', userId);
    final response = await supabase.auth.updateUser(
      UserAttributes(email: _emailController.text),
    );

    if (response.user?.newEmail != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating email: $response')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Changes saved successfully!')),
      );
      Navigator.pop(context);
      AppRoutes.navigateToAccountSettings(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Edit Profile', style: TextStyle(fontSize: 24)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: 70.sp,
                backgroundImage: _avatarUrl != null
                    ? NetworkImage(_avatarUrl!)
                    : const AssetImage('assets/default_avatar.png')
                        as ImageProvider<Object>,
                child: _avatarUrl == null
                    ? Icon(Icons.camera_alt, size: 40.sp, color: Colors.white)
                    : null,
              ),
            ),
            SizedBox(height: 20.h),
            TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(fontSize: 15.sp)),
            SizedBox(height: 20.h),
            TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(fontSize: 15.sp)),
            SizedBox(height: 20.h),
            SizedBox(
                width: 200.w,
                height: 40.sp,
                child: ElevatedButton(
                  onPressed: _updateProfile,
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                )),
            SizedBox(height: 20.h),
            SizedBox(
              width: 200.w,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
            ),
            SizedBox(height: 20.h)
          ],
        ),
      ),
    );
  }
}
