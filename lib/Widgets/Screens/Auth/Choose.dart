import 'package:flutter/material.dart';
import 'package:TravelGo/Widgets/Buttons/WithMethodButtons/BlueButton.dart';
import 'package:TravelGo/Widgets/Buttons/WithMethodButtons/GreenButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Welcomepage());
}

class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome Page',
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final LinearGradient gradient = const LinearGradient(
    colors: [Colors.blueAccent, Color.fromARGB(255, 206, 19, 19)],
    begin: Alignment.topCenter,
    end: Alignment.centerLeft,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDEEFFC),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 20.h,
            right: -30,
            left: -30,
            child: Stack(children: <Widget>[
              Align(
                child: Image.asset(
                  'assets/images/icon/newlogo.png',
                  fit: BoxFit.cover,
                  height: 152.h,
                  width: 200.w,
                ),
              ),
              Positioned(
                top: 100,
                bottom: 50, // Adjust the position of the second image
                right: -30,
                left: -30,  // Change as needed
                child: Image.asset(
                  'assets/images/icon/airplanelogo.png', // Replace with your image path
                  height: 450.h, // Adjust the size
                  width: 350.w,  // Adjust the size
                ),
              ),
              Container(
                height: 470.h,
                width: 510.w,
              )
            ]),
          ),
          Positioned(
            top: 350.h,
            right: 0,
            left: 0,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 20, right: 90),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(right: 50, top: 20),
                            child: Text(
                              'Welcome to',
                              style: TextStyle(
                                color: const Color(0xFF2D3F4E),
                                fontSize: 35.sp,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 95),
                              child: Text(
                                'TRAVEL GO',
                                style: TextStyle(
                                  color: const Color(0xFF44CAF9),
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          const SizedBox(
                            height: 15,
                          ),
                  Container(
                    width: 700.w,
                    padding: EdgeInsets.only(top: 5.h, left: 30.w), // Adjusted padding, no left/right padding
                    child: Text(
                      'Travel and get more experience here in Pangasinan! \n \nExplore the stunning beaches, rich culture, and hidden gems of Pangasinan with ease! It simplifies your journey, offering seamless booking options, accurate travel cost estimates, and insider tips to make your trip unforgettable.',
                      textAlign: TextAlign.left, // Keep the alignment to left
                      style: TextStyle(
                        color: const Color(0xFF2D3F4E),
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 900.h),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0.h, bottom: 20.h),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 4.h),
                                  ),
                                ],
                              ),
                              width: 270.w,
                              height: 40.h,
                              child: Bluebottle(
                                color: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 50, 190, 255),
                                ),
                                text: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.h, bottom: 30.h),
                            child: Container(
                              padding: EdgeInsets.only(top: 0.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2.h,
                                    blurRadius: 4.h,
                                    offset: Offset(0.h, 4.h),
                                  ),
                                ],
                              ),
                              width: 270.w,
                              height: 40.h,
                              child: Greenbutton(
                                text: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                color: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
