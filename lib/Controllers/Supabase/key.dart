import 'package:supabase_flutter/supabase_flutter.dart';
const url = 'https://cdfmtahwfxugtjaplfjt.supabase.co';
const apikey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNkZm10YWh3Znh1Z3RqYXBsZmp0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQxNDA4NTQsImV4cCI6MjAzOTcxNjg1NH0.t2RxCaEhF3yAuuf2Chug2uGz6Vf_VND1AuoO9wqU_8s';
// ignore: camel_case_types
class database{
   static void supabase() async{
  await Supabase.initialize(
    url: url, 
    anonKey: apikey
    );
}
final superbase =  Supabase.instance.client;
}
