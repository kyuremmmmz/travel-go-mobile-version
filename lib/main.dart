import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil for responsive
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

const url1 = 'https://tglolshdsrixggmpvujc.supabase.co';
const apikey1 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRnbG9sc2hkc3JpeGdnbXB2dWpjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjk2NDk4NjcsImV4cCI6MjA0NTIyNTg2N30.XfbqqyLUu-qEZhi9kEHv5HQ3ZHBTeJKgXWnfd1VXT88';
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
