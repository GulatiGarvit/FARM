import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Location {
  String name;
  String district;
  String region;
  String state;

  Location(this.name, this.district, this.region, this.state);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        json['Name'], json['District'], json['Region'], json['State']);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Location> locations = [];
  String status = '';

  _getLocations(pincode) {
    setState(() {
      status = 'Please wait...';
    });
    final JsonDecoder _decoder = const JsonDecoder();
    http
        .get(Uri.parse("http://www.postalpincode.in/api/pincode/147001"))
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }

      setState(() {
        var json = _decoder.convert(res);
        var tmp = json['PostOffice'] as List;
        var city = tmp.first['District'] as String;
        print(city);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              key: GlobalKey<FormState>(),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                labelText: "Pincode",
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              onFieldSubmitted: (val) => _getLocations(val),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(status,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: locations.length,
                itemBuilder: (BuildContext context, int index) {
                  final Location location = locations.elementAt(index);

                  return Card(
                    child: ListTile(
                      title: Text(location.name),
                      subtitle: Text('District: ' +
                          location.district +
                          '\nRegion: ' +
                          location.region +
                          '\nState: ' +
                          location.state),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
