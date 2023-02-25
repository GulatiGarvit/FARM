import 'package:flutter/material.dart';
import 'package:mlsc_hackathon/FirstPage/firstpage.dart';
import 'package:mlsc_hackathon/GetUserDetails/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
    );
  }
}
