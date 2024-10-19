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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -90.h,
            right: -30.w,
            left: -30.w,
            child: Stack(children: <Widget>[
              Align(
                child: Image.asset(
                  'assets/images/Background.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height - 350.h,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width + 100.w,
                color: Colors.black.withOpacity(0.2),
              )
            ]),
          ),
          Positioned(
            top: 300.h,
            right: 0,
            left: 0,
            height: MediaQuery.of(context).size.height,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20.h),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 8,
                    offset: const Offset(0, 10),
                  )
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 20.h, right: 50.h),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 50.h, top: 20.h),
                            child: FittedBox(
                              child: Text(
                                'Welcome to',
                                style: TextStyle(
                                  fontSize: 35.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 95.w),
                            child: ShaderMask(
                              shaderCallback: (bounds) {
                                return gradient.createShader(Rect.fromLTWH(
                                    0, 0, bounds.width, bounds.height));
                              },
                              child: Text(
                                'TRAVEL GO',
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5.h, left: 35.w),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              'Travel and get more experience here in Pangasinan! \n \nExplore the stunning beaches, rich culture, and hidden gems of Pangasinan with ease! It simplifies your journey, offering seamless booking options, accurate travel cost estimates, and insider tips to make your trip unforgettable.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 14.sp,
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
                      padding: EdgeInsets.only(bottom: 300.h),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
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
                              width: MediaQuery.of(context).size.width - 120.w,
                              child: Bluebottle(
                                color: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 50, 190, 255),
                                ),
                                text: Text(
                                  'Log In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
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
                              width: MediaQuery.of(context).size.width - 120.w,
                              child: Greenbutton(
                                text: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                color: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFDFEFF2),
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
