import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackathon/HomePage/map.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QRCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QRCodeState();
}

class QRCodeState extends State<QRCode> {
  String? lat, long;
  @override
  Widget build(BuildContext context) {
    callback(String lat, String long) {
      setState(() {
        this.lat = lat;
        this.long = long;
      });
    }

    MyMap(callback);
    // User user = FirebaseAuth.instance.currentUser!;
    return SafeArea(
        child: Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: QrImage(
          data: "uid=&latlong=${callback(lat!, long!)}",
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    ));
  }
}
