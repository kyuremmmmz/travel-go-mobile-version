import 'dart:convert';
import 'package:TravelGo/Controllers/NetworkImages/food_area.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/maps/foodPlacesDetailsModal.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class FoodPlaceMap extends StatelessWidget {
  final String? location;
  final int id;
  final int text;
  final String? price;
  const FoodPlaceMap({
    super.key,
    required this.location,
    required this.id,
    required this.text,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: FoodPlaceMapPage(location: location, id: id),
    );
  }
}

class FoodPlaceMapPage extends StatefulWidget {
  final String? location;
  final int id;
  final String? price;
  const FoodPlaceMapPage({
    super.key,
    required this.location,
    required this.id,
    this.price,
  });

  @override
  State<FoodPlaceMapPage> createState() => _FoodPlaceMapPageState();
}

class _FoodPlaceMapPageState extends State<FoodPlaceMapPage> {
  final start = TextEditingController();
  final end = TextEditingController();
  List<LatLng> routePoints = [const LatLng(15.91667, 120.33333)];
  String? foodAreaName;
  String? located;
  String? text;
  String? description;
  var price;
  List<Marker> markers = [];
  var imageUrlForDine = <String, dynamic>{};
  var dine = <String, dynamic>{};
  final data = FoodAreaBackEnd();
  late FoodAreaBackEnd images = FoodAreaBackEnd();
  Future<void> func() async {
    try {
      List<Location> startR = await locationFromAddress(start.text.trim());
      List<Location> endR = await locationFromAddress('${widget.location}');

      final v1 = startR[0].latitude;
      final v2 = startR[0].longitude;
      final v3 = endR[0].latitude;
      final v4 = endR[0].longitude;

      var url = Uri.parse(
        'http://router.project-osrm.org/route/v1/driving/$v2,$v1;$v4,$v3?steps=true&annotations=true&geometries=geojson&overview=full',
      );

      var response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['routes'].isNotEmpty) {
          setState(() {
            routePoints = [];
            var router = data['routes'][0]['geometry']['coordinates'];
            for (var coords in router) {
              double latitude = coords[1].toDouble();
              double longitude = coords[0].toDouble();
              routePoints.add(LatLng(latitude, longitude));
            }
          });
        } else {
          print('No routes found.');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  Future<void> places(int id) async {
    final data = await images.getSpecificData(id);
    setState(() {
      foodAreaName = data?['img'];
      price = data?['price'];
      located = data?['located'];
      description = data?['description'];
    });
  }

  Future<void> getMarkers() async {
    try {
      final foodAreas = await images.getFood();

      if (foodAreas.isNotEmpty) {
        List<Marker> fetchedMarkers = [];

        for (var foodArea in foodAreas) {
          var foodAreaName = foodArea['img'];
          var foodAreaPrice = foodArea['price'];
          var numberFormat = NumberFormat('#,###');
          var finalPrice = numberFormat.format(foodAreaPrice);
          foodArea['price'] = finalPrice;
          foodArea['img'] = foodAreaName;
          List<Location> locations = await locationFromAddress(foodArea['img']);
          if (locations.isNotEmpty) {
            double lat = locations[0].latitude;
            double lng = locations[0].longitude;

            fetchedMarkers.add(
              Marker(
                point: LatLng(lat, lng),
                width: 80.w,
                height: 80.h,
                child: Column(
                  children: [
                    Container(
                        width: 80.w,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => FoodPlacesDetailsModal(
                                      id: widget.id,
                                    ));
                          },
                          child: Text(
                            '₱$finalPrice',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    const Icon(Icons.location_on, color: Colors.red),
                  ],
                ),
              ),
            );
          }
        }

        setState(() {
          markers = fetchedMarkers;
        });
      }
    } catch (error) {
      print('Error fetching places: $error');
    }
  }

  @override
  void dispose() {
    start.dispose();
    end.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getMarkers();
    places(widget.id);
  }

  Future<void> detailsModal(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => FoodPlacesDetailsModal(
              id: widget.id,
            ));
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TitleMenu(),
              SizedBox(height: 10.h),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text(
                    'Location Guide:',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  )),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    '$located',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 500.h,
                // width: 400.w,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: routePoints.isNotEmpty
                        ? routePoints[0]
                        : const LatLng(15.91667, 120.33333),
                    initialZoom: 10,
                  ),
                  children: [
                    const SimpleAttributionWidget(
                      source: Text('Open Street Map Contributors'),
                      onTap: null,
                    ),
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.itransit',
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: routePoints,
                          color: Colors.red,
                          strokeWidth: 3.0,
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: markers,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: 150.w,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () async {
                      detailsModal(context);
                    },
                    child: Text(
                      'See Details',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
