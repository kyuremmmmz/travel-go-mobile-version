import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/Auth/Choose.dart';
import 'package:itransit/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../App/exploreNow.dart';

// ignore: camel_case_types
class explore extends StatelessWidget {
  const explore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, 
        home: StreamBuilder<AuthState>(
        stream: supabase.auth.onAuthStateChange,
        builder: (context, snapshot) {
          final session = snapshot.data?.session;
          Future.delayed(const Duration(seconds: 4));
          return session == null ? const Welcomepage() : const Explorenow();
        },
      ),

    );
  }
}
