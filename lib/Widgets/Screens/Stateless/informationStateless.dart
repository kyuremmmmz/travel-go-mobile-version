import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/App/information.dart';
import 'package:itransit/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:itransit/Widgets/Screens/Auth/Choose.dart';

class InformationStateless extends StatelessWidget {
  const InformationStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<AuthState>(
          stream: supabase.auth.onAuthStateChange,
          builder: (context, snapshot) {
            final session = snapshot.data?.session;
            return session == null
                ? const Welcomepage()
                : const InformationScreen();
          }
        ),
    );
  }
}
