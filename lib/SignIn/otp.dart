import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mlsc_hackathon/GetUserDetails/main.dart';
import 'package:mlsc_hackathon/HomePage/main.dart';
import 'package:mlsc_hackathon/Helpers/theme.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../firebase_options.dart';

class Otp extends StatefulWidget {
  var phoneNumber, name;
  Otp(this.phoneNumber, this.name);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String? pin, verificationId;
  @override
  void initState() {
    sendOTP();
    super.initState();
  }

  sendOTP() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        Fluttertoast.showToast(msg: "Verified!");
      },
      verificationFailed: (FirebaseAuthException e) {
        Fluttertoast.showToast(msg: "Failed");
      },
      codeSent: (String verificationId, int? resendToken) async {
        Fluttertoast.showToast(msg: "Code sent");
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  OtpFieldController otpController = OtpFieldController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Text(
              'Enter the OTP sent to ${widget.phoneNumber}',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: OTPTextField(
                  controller: otpController,
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 45,
                  fieldStyle: FieldStyle.underline,
                  outlineBorderRadius: 15,
                  style: TextStyle(fontSize: 17),
                  onChanged: (pin) {
                    this.pin = pin;
                  },
                  onCompleted: (pin) {
                    this.pin = pin;
                  }),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () async {
                  String smsCode = pin!;
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationId!, smsCode: smsCode);
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(credential)
                        .then((value) async {
                      Fluttertoast.showToast(msg: "Hogya login");
                      final snapshot = await FirebaseDatabase.instance
                          .ref()
                          .child('Users')
                          .child(value.user!.uid)
                          .get();
                      if (!snapshot.exists) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return GetUserDetails();
                        }));
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Homepage();
                        }));
                      }
                    });
                  } on FirebaseAuthException catch (e) {
                    Fluttertoast.showToast(
                        msg: e.code == 'invalid-verification-code'
                            ? 'Galat code hai bc'
                            : 'Pta ni kya hua');
                  }
                },
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          'Verify',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
