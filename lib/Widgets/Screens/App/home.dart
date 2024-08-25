import 'package:flutter/material.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Widgets/Buttons/DefaultButtons/RedButton.dart';
import 'package:itransit/Widgets/Screens/Auth/Choose.dart';
import 'package:itransit/main.dart';
class Home extends StatefulWidget {
  void main(){
    runApp(const Home());
  }
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? email;
  late Usersss users = Usersss();
  
  @override
  void initState(){
    super.initState();
    emailFetching();
  }

  Future <void> emailFetching() async{
      final useremail = await users.fetchUser();
      setState(() {
        email = useremail;
      });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: 
                Text(
                  email != null 
                  ? 'Welcome $email' 
                  : 'Hacked himala e',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container
              (
                  padding: const EdgeInsets.only
                  (
                    top:0,
                  ),
                  child: RedButton
                  (
                    callbackAction: (){
                      Usersss().signout();
                      if (supabase.auth.currentSession == null) {
                        const Welcomepage();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber
                    ),
                text: const Text
                (
                  'LOG OUT', 
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0)
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}