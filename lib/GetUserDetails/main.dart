import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mlsc_hackathon/HomePage/main.dart';
import 'package:mlsc_hackathon/Helpers/theme.dart';

import 'package:http/http.dart' as http;

import 'location.dart';

class GetUserDetails extends StatefulWidget {
  @override
  State<GetUserDetails> createState() => _GetUserDetailsState();
}

class _GetUserDetailsState extends State<GetUserDetails> {
  List<Location> locations = [];

  String status = '';

  var name, pincode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: kPrimaryColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                      width: 1.0,
                    ),
                  ),
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  labelText: 'Pin Code',
                  labelStyle: TextStyle(color: kPrimaryColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                      width: 1.0,
                    ),
                  ),
                ),
                onChanged: (value) {
                  pincode = value;
                },
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 120, vertical: 12)),
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                ),
                onPressed: () {
                  getLocations(pincode);
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getLocations(pincode) async {
    final JsonDecoder _decoder = const JsonDecoder();
    await http
        .get(Uri.parse("http://www.postalpincode.in/api/pincode/$pincode"))
        .then((http.Response response) async {
      final String res = response.body;
      final int statusCode = response.statusCode;

      var json = _decoder.convert(res);
      var tmp = json['PostOffice'] as List;
      var city = tmp.first['District'] as String;
      await FirebaseDatabase.instance
          .ref()
          .child('Users')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .set({'name': name, 'city': city, 'pincode': pincode});
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Homepage();
    }));
  }
}
