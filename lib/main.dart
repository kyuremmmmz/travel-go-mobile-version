import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Widgets/Screens/App/mainmenu.dart';
import 'Widgets/Screens/Auth/Choose.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Set your design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Travel go',
          home: StreamBuilder<AuthState>(
            stream: supabase.auth.onAuthStateChange,
            builder: (context, snapshot) {
              final session = snapshot.data?.session;
              Future.delayed(const Duration(seconds: 4));
              return session == null ? const Welcomepage() : const MainMenuScreen();
            },
          ),
        );
      },
    );
  }
}

const url1 = 'https://nvscibwjxhrctgfhrgyn.supabase.co';
const apikey1 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im52c2NpYndqeGhyY3RnZmhyZ3luIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQyMTI0NDQsImV4cCI6MjAzOTc4ODQ0NH0.PLKN-tw8vMLxgwnunGotYP_U6AM2_A2dN-ATeykj7bI';

// ignore: camel_case_types
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: url1,
    anonKey: apikey1,
  );
  runApp(const WelcomePage());
}

final supabase = Supabase.instance.client;
