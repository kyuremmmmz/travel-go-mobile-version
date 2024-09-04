import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:itransit/Widgets/Screens/Auth/Choose.dart';
import 'package:itransit/Widgets/Screens/App/information.dart';

class InformationStateless extends StatelessWidget {
  final String text;
  final String description;

  const InformationStateless({
    super.key,
    required this.text,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AuthState>(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          final session = snapshot.data?.session;
          return session == null
              ? const Welcomepage()
              : InformationScreen(
                  text: text,
                  description: description,
                );
        },
      ),
    );
  }
}
