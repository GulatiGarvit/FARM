import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/HomePage/theme.dart';
import 'package:hackathon/QR/qr_code.dart';

import '../firebase_options.dart';

class UserInfoBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserInfoBarState();
}

class UserInfoBarState extends State<UserInfoBar> {
  @override
  void initState() {
    initializeFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var user = FirebaseAuth.instance.currentUser!;
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 8.0,
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22), topRight: Radius.circular(22))),
      child: Column(
        children: [
          // Text(
          //   'Hello,${user.providerData[0].displayName}',
          //   style: TextStyle(fontSize: 25, color: kPrimaryColor),
          // ),
          Spacer(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )),
                backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                elevation: MaterialStateProperty.all(4),
              ),
              child: Text(
                'Start a ride',
                style: TextStyle(color: kBackgroundColor, fontSize: 15),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRCode(),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
