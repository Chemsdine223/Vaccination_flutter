import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vaccination/Data/Models/user.dart';
import 'package:vaccination/Data/auth/auth_service.dart';
// import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Position? _currentPosition;
  bool isLoading = true;
  // Position _position

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

    final Position position;

    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      // print(e);
      throw e.toString();
    }

    print(_currentPosition);

    return position;
  }

  // List<Marker> markers = [
  //   Marker(
  //     width: 80.0,
  //     height: 80.0,
  //     point: LatLng(18.10089, -15.991947409354378),
  //     builder: (ctx) => const Icon(Icons.location_on),
  //   ),
  //   Marker(
  //     width: 100.0,
  //     height: 100.0,
  //     point: LatLng(18.10089, -15.991947409354378),
  //     builder: (ctx) => const Icon(
  //       Icons.location_on,
  //       size: 40,
  //     ),
  //   ),
  // ];

  late GoogleMapController mapController;
  // Set<Marker> markers = {};

  @override
  void initState() {
    // const marker = Marker(
    //   markerId: MarkerId('marker_id_1'),
    //   position: LatLng(18.079021, -15.965662),
    //   infoWindow: InfoWindow(title: 'Centre de TVZ'),
    // );

    // setState(() {
    //   markers.add(marker);
    // });
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
                child: CircularProgressIndicator(),
              )
            : FutureBuilder(
                future: CentreRepo().fetchCentreList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Centre> centres = snapshot.data!;
                    print(
                        '${double.parse(centres[2].latitude)} !!!!!!!!========');
                    print('${double.parse(centres[2].longitude)} ========');
                    return GoogleMap(
                      onMapCreated: (controller) {
                        setState(
                          () {
                            mapController = controller;
                          },
                        );
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                        ),
                        zoom: 12,
                      ),
                      zoomControlsEnabled: false,
                      // compassEnabled: true,
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
                            // icon: Icon(Icons.pin),
                            infoWindow: InfoWindow(
                              title: centre.nom,
                            ),
                          ),
                        ),
                        // compassEnabled: false,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ));
  }
}
