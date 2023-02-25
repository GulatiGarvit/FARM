import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mlsc_hackathon/Helpers/measurement.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var measurements = <Measurement>[];
  @override
  void initState() {
    fetchData().then((value) {
      setState(() {});
    });
    super.initState();
  }

  Future<void> fetchData() async {
    final snap = await FirebaseDatabase.instance
        .ref()
        .child('Measurements')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .get();
    for (final snapshot in snap.children) {
      Measurement measurement = Measurement();
      measurement.illumination = snapshot.child('illumination').value as int;
      measurement.moisture = snapshot.child('moisture').value as int;
      measurement.npk = snapshot.child('npk').value as String;
      measurement.ph = snapshot.child('pH').value as double;
      measurements.add(measurement);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            itemBuilder: (context, index) {
              return Card(
                clipBehavior: Clip.antiAlias,
                elevation: 4,
                margin: EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: InkWell(
                  onTap: () {},
                  splashFactory: InkRipple.splashFactory,
                  child: Container(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Moisture Levels'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('pH Levels'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Soil Illumination Levels'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('NPK Levels'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}
