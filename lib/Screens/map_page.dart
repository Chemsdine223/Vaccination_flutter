import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vaccination/Data/Models/user.dart';
import 'package:vaccination/Data/auth/auth_service.dart';
import 'package:vaccination/Screens/loading.dart';
// import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Position? _currentPosition;
  bool isMounted = false;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position;

    try {
      print(_currentPosition);
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      await Future.delayed(Duration(seconds: 3));
      if (isMounted) {
        setState(
          () {
            _currentPosition = position;
          },
        );
      }
    } catch (e) {
      // print(e);
      throw e.toString();
    }

    print(_currentPosition);
    return position;
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    isMounted = true;
    _determinePosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // floatingActionButton: FloatingActionButton(onPressed: () async {
      //   final p = await _determinePosition();
      //   print(p);
      // }),
      backgroundColor: Colors.white,
      body: _currentPosition == null
          ? const Center(
              child: LoadingScreen(),
            )
          : FutureBuilder(
              future: CentreRepo().fetchCentreList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Centre> centres = snapshot.data!;
                  return GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      print('hello');
                      _controller.complete(controller);
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      ),
                      zoom: 12,
                    ),
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    markers: Set<Marker>.from(
                      centres.map(
                        (centre) => Marker(
                          markerId: MarkerId(centre.nom.toString()),
                          position: LatLng(
                            double.parse(centre.latitude),
                            double.parse(centre.longitude),
                          ),
                          infoWindow: InfoWindow(
                            title: centre.nom,
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Helloooooo ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
    );
  }

  @override
  void didChangeDependencies() {
    isMounted = true;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }
}
