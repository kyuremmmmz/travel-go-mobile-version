import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/App/mainmenu.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:itransit/Widgets/Screens/Auth/Choose.dart';

class InformationStateless extends StatelessWidget {
  final String text;
  const InformationStateless({
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
          return session == null
              ? const Welcomepage()
              : const MainMenu();
        },
      ),
    );
  }
}
