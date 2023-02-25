import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import '../firebase_options.dart';

class MyMap extends StatefulWidget {
  Function? callback;

  MyMap(this.callback);

  @override
  State<MyMap> createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  var markers = <Marker>[].toSet();
  bool isStandsDataLoaded = false;

  @override
  void initState() {
    super.initState();
    initializeFirebase().then((value) {
      fetchStands();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: markers,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(lat), double.parse(long)),
          zoom: 18,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Future<void> fetchStands() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Stands').get();
    for (var standSnapshot in snapshot.children) {
      Marker marker = Marker(
        markerId: MarkerId(standSnapshot.key!),
        position: LatLng(
            double.parse(
                standSnapshot.child("latLong").value.toString().split(',')[0]),
            double.parse(
                standSnapshot.child("latLong").value.toString().split(',')[1])),
        infoWindow: InfoWindow(
          title: standSnapshot.key,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );
      markers.add(marker);
    }

    setState(() {});
  }

  Future<void> getAddress() async {
    List<Placemark> addresses =
        await placemarkFromCoordinates(double.parse(lat), double.parse(long));
    var address = addresses.first;
    print(address.toString());
    widget.callback!.call("${address.name}, ${address.subAdministrativeArea}");
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void fetchUserDetails() {}
}
