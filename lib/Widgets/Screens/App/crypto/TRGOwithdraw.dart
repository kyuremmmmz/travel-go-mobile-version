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

  final trgo = Trgo();

  // Create a stream to fetch the withdrawable points
  Stream<num> getWithdrawablePoints() async* {
    while (true) {
      final response = await trgo.getTheWithdrawPoints();
      yield response!['withdrawablePoints'];
      await Future.delayed(const Duration(
          seconds: 5)); // Delay for 5 seconds before the next fetch
    }
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
                StreamBuilder<num>(
                  stream: getWithdrawablePoints(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Show loading indicator while fetching
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Center(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: '${snapshot.data}',
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
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 30.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WithdrawScreen( ),
                      ),
                    )
                  },
                  child: Text(
                    'Withdraw Points',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
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
                                            "assets/images/icon/gift.png"),
                                      ),
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
                                            "assets/images/icon/coin-stack.png"),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.only(top: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.sp),
                      topRight: Radius.circular(25.sp),
                    ),
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
                      ],
                    ),
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
                        ),
                      ),
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
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
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
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rowsOfIcons({
    required String image,
    required Set<void> Function() oppressed,
    required String text,
    required String subtext,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: oppressed,
          child: ClipOval(
            child: Image.asset(
              image,
              width: 50.w,
              height: 50.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp),
        ),
        Text(
          subtext,
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 10.sp, color: Colors.grey),
        )
      ],
    );
  }

  Widget buildSection({required Widget content}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      padding: EdgeInsets.all(15.sp),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: content,
    );
  }

  Widget rowIconAndText({required String number, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14.sp, color: Colors.blue),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
