// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TravelGo/Controllers/NetworkImages/food_area.dart';
import 'package:TravelGo/Controllers/NetworkImages/vouchers.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Controllers/TRGO_POINTS/Trgo.dart';
import 'package:TravelGo/Widgets/Buttons/WithMethodButtons/VoucherButton.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:TravelGo/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ResponsiveScreen/ResponsiveScreen.dart'; // Import ScreenUtil for responsive

class DiscountArea extends StatelessWidget {
  const DiscountArea({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel',
      home: DiscountAreaScreen(),
    );
  }
}


class DiscountAreaScreen extends StatefulWidget {
  const DiscountAreaScreen({super.key});

  @override
  State<DiscountAreaScreen> createState() => _DiscountAreaScreenState();
}

class _DiscountAreaScreenState extends State<DiscountAreaScreen> {
  final String hundredIsland = "assets/images/places/HundredIsland.jpeg";

  String? email;
  String? img;
  List res = [];
  List result = [];

  final data = FoodAreaBackEnd();
  final fetchDiscounts = Vouchers();
  final tr = Trgo();
  final _searchController = TextEditingController();
  late Usersss users = Usersss();
  var dateNoww = DateTime.now();
  String formattedDate = '';
  num TrgoPoints = 0.0;
  String messageprogress = '';
  num percentprogress = 0.0;
  num percentcompute = 0.0;
  int messagesize = 13; // resize for updated points
  bool _isRedirecting = false;
  // 100 is full progress bar
  // value of points and progress bar, except the decimal point
  Stream<num> getPointsStream() async* {
    while (true) {
      final response = await tr.getThePointsOfMine();
      yield response!['withdrawablePoints'];
      await Future.delayed(const Duration(seconds: 5));
    }
  }
  Future<void> gett() async {
    final response = await tr.getThePointsOfMine();
    setState(() {
      TrgoPoints = response!['withdrawablePoints'];
      if (TrgoPoints >= 1) {
        percentprogress = TrgoPoints * 0.01; // Formula 100 points to full
        messageprogress =
            "Feel free to use your points now! \nCollect more points and save big!";
      } else {
        percentprogress = TrgoPoints;
        messagesize = 10; // small text size for less points
        messageprogress =
            "Earn points and enjoy discounts on your next booking! \nStart collecting points now and save big!";
      }
      if (TrgoPoints >= 100) {
        percentprogress =
            (TrgoPoints - 100) * 0.01; // Formula 200 points to full
        messageprogress =
            "Congratulations! \nYour points have reached Silver status!";
      }
      if (TrgoPoints >= 200) {
        percentprogress =
            (TrgoPoints - 200) * 0.01; // Formula 300 points to full
        messageprogress =
            "Congratulations! \nYour points have reached Gold status!";
      }
      if (TrgoPoints >= 300) {
        percentprogress =
            (TrgoPoints - 300) * 0.01; // Formula 400 points to full
        messageprogress =
            "Congratulations! \nYour points have reached Platinum status!";
      }
      if (TrgoPoints >= 400) {
        messageprogress =
            "Congratulations! \nYour points have reached Diamond status!";
      }
      _isRedirecting = false;
    });
  }

  Future<void> update() async {
    setState(() {
      tr.updatePointsToMoney(context);
      _isRedirecting = false;
    });
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
    fetchDiscount();
    gett();
    update();
    _isRedirecting = true;
  }

  Future<void> fetchDiscount() async {
    final user = supabase.auth.currentUser!.id;
    final response = await fetchDiscounts.getTheDiscountsAsList(user);
    setState(() {
      res = response;
      formattedDate = DateFormat('MMMM dd').format(dateNoww);
    });
  }

  Future<void> emailFetching() async {
    try {
      final PostgrestList useremail = await users.fetchUser();
      if (useremail.isNotEmpty) {
        setState(() {
          email = useremail[0]['full_name'].toString();
          img = useremail[0]['avatar_url'].toString();
          _isRedirecting = false;
        });
      } else {
        setState(() {
          email = "Anonymous User";
          _isRedirecting = false;
        });
      }
    } catch (e) {
      setState(() {
        email = "error: $e";
        _isRedirecting = false;
      });
    }
  }

  String calculateRemainingTime(String expiryTime) {
    DateTime expiryDate = DateTime.parse(expiryTime);
    DateTime currentDate = DateTime.now();
    Duration difference = expiryDate.difference(currentDate);
    int remainingHours = difference.inHours;
    int remainingMinutes = difference.inMinutes.remainder(60);

    if (remainingHours > 0) {
      return '$remainingHours hours and $remainingMinutes minutes left';
    } else if (remainingMinutes > 0) {
      return '$remainingMinutes minutes left';
    } else {
      return 'Expired';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.h,
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: const DrawerMenuWidget(),
      body: _isRedirecting == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Stack(
              children: [
                Positioned.fill(
                    child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    const TitleMenu(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 30.h),
                        buildUserCard(),
                        SizedBox(height: 30.h),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20.w),
                            child: Text('Available Discount Vouchers',
                                style: TextStyle(
                                    color: const Color(0xFF333131),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold))),
                        buildDiscountList(),
                      ],
                    ),
                  ]),
                ))
              ],
            ),
    );
  }

  Widget button() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {
          print('test');
        },
        child: const Text(
          'Create my Wallet',
          style: TextStyle(color: Colors.white),
        ));
  }

  Widget buildUserCard() {
    // SPEND WISE BOX AREA
    return TrgoPoints == 0.0
        ? GestureDetector(
            onTap: () {
              tr.createPoints(context);
            },
            child: const Center(
              child: Text('Create TRGO Points'),
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            width: 340.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 0.2.sp, // border line thickness
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.grey.withOpacity(0.5), // Shadow color with opacity
                  blurRadius: 4, // Blur radius
                  offset: Offset(0.w, 4.h), // Shadow position (x, y)
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFF1FCFF),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildUserInfo(),
                SizedBox(height: 10.h),
                buildPointsInfo(),
              ],
            ),
          );
  }

// PROFILE

  Widget buildUserInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: Responsive().discountProfileRadius(),
          backgroundImage: img == null
              ? const AssetImage('assets/images/icon/user.png')
              : NetworkImage('$img'),
        ),
        SizedBox(width: 15.w, height: 50.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Spend wise and use',
                style: TextStyle(
                    fontWeight: FontWeight.w500, // medium fontweight
                    fontSize: 12.sp,
                    color: const Color(0xFF0567B4))),
            Text(email ?? 'Loading...', // NAME OF THE USER AREA
                style: TextStyle(
                    color: const Color(0xFF333131),
                    fontSize: 23.sp,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ],
    );
  }

  Widget buildPointsInfo() {
    // TRAVEL GO POINTS BOX AREA
    return Container(
      padding: EdgeInsets.all(10.w),
      width: 350.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.5.sp, // border line thickness
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SizedBox(
              width: 30.sp,
              height: 30.sp,
              child: Image.asset("assets/images/icon/coin-stack.png")),
          SizedBox(width: 5.w),
          Expanded(
            child: Column(
              children: [
                buildPointsHeader(),
                buildPointsProgress(),
                buildPointsInfoText()
              ],
            ),
          ),
        ],
      ),
    );
  }

 Widget buildPointsHeader() {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.w, right: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('My Points',
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold)),
          StreamBuilder<num>(
            stream: getPointsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Loading indicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                TrgoPoints = snapshot.data ?? 0.0;
                formattedDate = DateFormat('MMMM dd yyyy')
                    .format(dateNoww);
                return RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '$TrgoPoints',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: ' as of $formattedDate',
                      style: TextStyle(fontSize: 11.sp, color: Colors.black),
                    ),
                  ]),
                );
              }
            },
          ),
        ],
      ),
    );
  }


  Widget buildPointsProgress() {
    // AREA OF YELLOW LINE
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: 2
                .h), // Add vertical padding for space above and below the progress bar
        child: LinearProgressIndicator(
            value: double.parse('$percentprogress'),
            minHeight: 5.h, // Height of the progress bar
            backgroundColor: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(5.sp),
            color: const Color(0xFFFFD989)));
  }

  Widget buildPointsInfoText() {
    return SizedBox(
        width: 300.w,
        child: Padding(
          padding:
              EdgeInsets.only(top: 10.h), // Add padding above the info text
          child: Text(
            messageprogress,
            style: TextStyle(
              fontSize: messagesize.sp,
              color: const Color(0xFF0567B4),
            ),
            textAlign: TextAlign.left,
          ),
        ));
  }

  Widget buildDiscountList() {
    // Available Vouchers Area
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: res.map((items) {
          final date = calculateRemainingTime(items['expiry']);
          return Container(
            padding: const EdgeInsets.all(20),
            width: 380.w,
            child: VoucherButton(
              voucherTitle:
                  'Enjoy up to ${items['discount']}% off at ${items['hotelName']}!',
              description:
                  'Book now and experience luxury at a discounted rate',
              expiring: date,
              image: items['ishotel'] == true
                  ? const AssetImage('assets/images/icon/hotel.png')
                  : const AssetImage('assets/images/icon/beach.png'),
              oppressed: () => 'Test',
            ),
          );
        }).toList(),
      ),
    );
  }
}
