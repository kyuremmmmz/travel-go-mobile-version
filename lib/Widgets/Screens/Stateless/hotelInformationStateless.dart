// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/App/mainmenu.dart';
import 'package:itransit/Widgets/Screens/Auth/Choose.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Hotelinformationstateless extends StatelessWidget {
  final int text;
  const Hotelinformationstateless({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<AuthState>(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          final session = snapshot.data?.session;
          return session == null ? const Welcomepage() : const MainMenu();
        },
      ),
    );
  }
}
