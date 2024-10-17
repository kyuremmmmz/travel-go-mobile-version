import 'dart:convert';
import 'package:TravelGo/Controllers/NetworkImages/hotel_images.dart';
import 'package:TravelGo/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class Map extends StatelessWidget {
  final String? location;
  final int id;
  const Map({
    super.key,
    required this.location,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: HotelMapPage(location: location, id: id),
    );
  }
}

class HotelMapPage extends StatefulWidget {
  final String? location;
  final int id;
  const HotelMapPage({
    super.key,
    required this.location,
    required this.id,
  });

  @override
  State<HotelMapPage> createState() => _HotelMapPageState();
}

class _HotelMapPageState extends State<HotelMapPage> {
  final start = TextEditingController();
  final end = TextEditingController();
  List<LatLng> routePoints = [const LatLng(15.91667, 120.33333)];
  String? placeName;
  String? located;
  var price;
  List<Marker> markers = [];

  late HotelImages images = HotelImages();
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
    final data = await images.fetchDataInSingle(id);
    setState(() {
      placeName = data!['hotel_name'];
      price = data['hotel_price'];
      located = data['hotel_located'];
    });
  }

  Future<void> getMarkers() async {
    try {
      final hotels = await images.fetchHotels();
      if (hotels.isNotEmpty) {
        List<Marker> fetchedMarkers = [];

        for (var hotel in hotels) {
          var hotelName = hotel['hotel_name'];
          var hotelPrice = hotel['hotel_price'];
          var des = hotel['hotel_description'];
          var numberFormat = NumberFormat('#,###');
          var finalPrice = numberFormat.format(hotelPrice);
          hotel['hotel_price'] = finalPrice;
          hotel['hotel_name'] = hotelName;
          hotel['description'] = des;
          List<Location> locations =
              await locationFromAddress(hotel['hotel_name']);
          if (locations.isNotEmpty) {
            double lat = locations[0].latitude;
            double lng = locations[0].longitude;

            fetchedMarkers.add(
              Marker(
                point: LatLng(lat, lng),
                width: 80,
                height: 80,
                child: Column(
                  children: [
                    Container(
                        width: 80,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(children: [
                                    Container(
                                      padding: null,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                          hotelName,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: null,
                                      width: double.infinity,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 50),
                                        child: const Text(
                                          'Description',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: null,
                                      width: double.infinity,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 50),
                                        child: Text(
                                          des,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ]);
                                });
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
      print('Error fetching hotels: $error');
    }
  }

  Future<void> detailsModal(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: null,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: null,
                  child: const Text(
                    'Booking Details',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Place name',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () async {},
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          );
        });
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
              const SizedBox(height: 30),
              Container(
                padding: EdgeInsets.only(right: 190.w, bottom: 5.h),
                child: const Text(
                  'Book your hotels nearby:',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                '$located',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 500,
                width: 400,
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
              const SizedBox(height: 30),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () async {
                      detailsModal(context);
                    },
                    child: const Text(
                      'See Details',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
