// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class Map extends StatelessWidget {
  final String? location;
  const Map({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapPage(location: location,),
    );
  }
}

class MapPage extends StatefulWidget {
  final String? location;
  const MapPage({
    super.key,
     required this.location,
    });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final start = TextEditingController();
  final end = TextEditingController();
  List<LatLng> routePoints = [const LatLng(15.91667, 120.33333)];
  bool _isVisible = true;
  @override
  void dispose() {
    start.dispose();
    end.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Map',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.grey,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: start,
              decoration: const InputDecoration(
                  hintText: 'Enter your Current Location',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  List<Location> startR =
                      await locationFromAddress(start.text.trim());
                  List<Location> endR =
                      await locationFromAddress('${widget.location}');
                  final v1 = startR[0].latitude;
                  final v2 = startR[0].longitude;
                  final v3 = endR[0].latitude;
                  final v4 = endR[0].longitude;
                  var url = Uri.parse(
                      'http://router.project-osrm.org/route/v1/driving/$v2,$v1;$v4,$v3?steps=true&annotations=true&geometries=geojson&overview=full');
                  var response = await http.get(url);
                  print(response.body);
                  setState(() {
                    routePoints = [];
                    var router = jsonDecode(response.body)['routes'][0]
                        ['geometry']['coordinates'];
                    for (var i = 0; i < router.length; i++) {
                      var reep = router[i].toString();
                      reep = reep.replaceAll("[", "");
                      reep = reep.replaceAll("]", "");
                      var l1 = reep.split(',');
                      var lng = reep.split(",");
                      routePoints.add(
                          LatLng(double.parse(l1[1]), double.parse(lng[0])));
                    }
                  });
                  _isVisible = !_isVisible;
                },
                child: const Text('Get location')),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 500,
              width: 400,
              child: Visibility(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: routePoints[0],
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
                    PolylineLayer(polylines: [
                      Polyline(
                          points: routePoints,
                          color: Colors.red,
                          strokeWidth: 3.0)
                    ])
                  ],
                ),
              ),
            )
          ],
        ))));
  }
}
