import 'package:supabase_flutter/supabase_flutter.dart';
const url = 'https://noutfbeahnhjwbbveqzz.supabase.co';
const apikey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5vdXRmYmVhaG5oandiYnZlcXp6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjEzMDIwNjMsImV4cCI6MjAzNjg3ODA2M30.XYQNUuJqPW7SufvUlRgNmC-cpnGY7z9XnuHyX_0p174';
// ignore: camel_case_types
class database{
  Future<void> supabase() async{
  await Supabase.initialize(
    url: url, 
    anonKey: apikey
    );
}
final superbase = Supabase.instance.client;
}
