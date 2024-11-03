import 'package:TravelGo/Controllers/TRGO_POINTS/Trgo.dart';
import 'package:TravelGo/Widgets/Buttons/WithMethodButtons/BlueIconButton.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/crypto/Withdrawal.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Trgowithdraw extends StatefulWidget {
  const Trgowithdraw({super.key});

  @override
  State<Trgowithdraw> createState() => _TrgowithdrawState();
}

class _TrgowithdrawState extends State<Trgowithdraw> {
  final String silverIcon = "assets/images/icon/silver.png";
  final String goldIcon = "assets/images/icon/gold.png";
  final String platinumIcon = "assets/images/icon/platinum.png";
  final String diamondIcon = "assets/images/icon/diamond.png";
  double bal = 0.0;
  final trgo = Trgo();
  Future<void> getBal() async {
    final response = await trgo.getTheWithdrawPoints();
    setState(() {
      bal = response!['withdrawablePoints'];
    });
  }

  @override
  void initState() {
    super.initState();
    getBal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TRGOYALTY WALLET'),
        ),
        drawer: const DrawerMenuWidget(),
        body: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const TitleMenu(),
                    SizedBox(height: 10.h),
                    Text(
                      'YOUR TRGOYALTY POINTS',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 48, 47, 47)),
                    ),
                    SizedBox(height: 20.h),
                    Center(
                        child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: '$bal',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40.sp,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' Points',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 30.sp,
                            color: Colors.blue,
                          ),
                        ),
                      ]),
                    )),
                    SizedBox(height: 30.h),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => WithdrawScreen(initialBalance: bal,)))
                        },
                        child: Text(
                          'Withdraw Points',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                          ),
                        )),
                    SizedBox(height: 20.h),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 175.sp,
                              child: Card(
                                color: const Color.fromARGB(252, 34, 90, 212),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 20.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: Text(
                                              'Browse all Rewards',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          CircleAvatar(
                                            radius: 25.sp,
                                            backgroundColor: Colors.white,
                                            child: ClipOval(
                                                child: Image.asset(
                                                    "assets/images/icon/gift.png")),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 175.sp,
                              child: Card(
                                color: const Color.fromARGB(252, 34, 90, 212),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 20.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: Text(
                                              'How to get Points?',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          CircleAvatar(
                                            radius: 25.sp,
                                            backgroundColor: Colors.transparent,
                                            child: ClipOval(
                                                child: Image.asset(
                                                    "assets/images/icon/coin-stack.png")),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: 10.h),
                    Container(
                        padding: EdgeInsets.only(top: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.sp),
                              topRight: Radius.circular(25.sp)),
                        ),
                        child: Column(children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 30.w),
                            child: Text(
                              'Popular Rewards',
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                rowsOfIcons(
                                    image: silverIcon,
                                    oppressed: () => {print('silver')},
                                    text: "Silver",
                                    subtext: "100 pts"),
                                rowsOfIcons(
                                    image: goldIcon,
                                    oppressed: () => {print('gold')},
                                    text: "Gold",
                                    subtext: "200 pts"),
                                rowsOfIcons(
                                    image: platinumIcon,
                                    oppressed: () => {print('platinum')},
                                    text: "Platinum",
                                    subtext: "300 pts"),
                                rowsOfIcons(
                                    image: diamondIcon,
                                    oppressed: () => {print('diamond')},
                                    text: "Diamond",
                                    subtext: "400 pts"),
                              ]),
                          SizedBox(height: 20.h),
                          buildSection(
                            content: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Text(
                                  "Earn points with every booking — reach Silver, Gold, Platinum, or Diamond for exclusive travel rewards!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue),
                                )),
                          ),
                          SizedBox(height: 20.h),
                          buildSection(
                              content: Column(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10.w),
                              child: Text(
                                'How It Works',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            rowIconAndText(
                                number: "1",
                                text:
                                    "You earn 20 points for every hotel booking, while 50 points for flight bookings in Travel Go."),
                            SizedBox(height: 10.h),
                            rowIconAndText(
                                number: "2",
                                text:
                                    "Use your points to redeem exciting deals and promotions."),
                            SizedBox(height: 10.h),
                            rowIconAndText(
                                number: "3",
                                text:
                                    "Earn enough points and level up to unlock exclusive benefits!"),
                            SizedBox(height: 10.h),
                          ])),
                          SizedBox(height: 20.h),
                        ]))
                  ],
                ),
              ),
            )));
  }

  Widget rowsOfIcons(
      {required String image,
      required Set<void> Function() oppressed,
      required String text,
      required String subtext}) {
    return Column(
      children: [
        BlueIconButtonDefault(image: image, oppressed: () => {oppressed}),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
        ),
        Text(
          subtext,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 11.sp, fontWeight: FontWeight.w500, color: Colors.blue),
        ),
      ],
    );
  }

  Widget buildSection({required content}) {
    return Container(
      width: 390.sp,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        border: Border.all(
          color: Colors.black,
          width: 0.5.w,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
            spreadRadius: 0, // How much the shadow spreads
            blurRadius: 4, // Softness of the shadow
            offset: const Offset(0, 4), // Offset of the shadow (x, y)
          ),
        ],
      ),
      child: content,
    );
  }

  Widget rowIconAndText({required String number, required text}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
                radius: 25.sp,
                backgroundColor: Colors.blue,
                child: Text(number,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold))),
            SizedBox(width: 10.w),
            Expanded(
                child: Text(text,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold)))
          ],
        ));
  }
}
