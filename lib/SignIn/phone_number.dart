import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mlsc_hackathon/Helpers/theme.dart';

import 'otp.dart';

class PhoneNumberInput extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey();
  var name;
  var phoneNumber;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Spacer(),
                  // TextField(
                  //   cursorColor: kPrimaryColor,
                  //   decoration: InputDecoration(
                  //     labelText: 'Name',
                  //     focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: kPrimaryColor)),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //       borderSide: BorderSide(
                  //         color: kPrimaryColor,
                  //         width: 1.0,
                  //       ),
                  //     ),
                  //   ),
                  //   onChanged: (value) {
                  //     name = value;
                  //   },
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  IntlPhoneField(
                    dropdownIcon: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: kPrimaryColor,
                    ),
                    cursorColor: kPrimaryColor,
                    initialCountryCode: 'IN',
                    disableLengthCheck: true,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 1.0,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    validator: (p0) {},
                    invalidNumberMessage: 'Enter a valid number',
                    onChanged: (phone) {
                      phoneNumber = phone.completeNumber;
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ' + country.name);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 00, 10),
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                'Submit',
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
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () {
                        name == null
                            ? Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Otp(phoneNumber, name)),
                                (Route<dynamic> route) => false)
                            : Fluttertoast.showToast(
                                msg: 'Please enter your name');
                        Fluttertoast.showToast(
                            msg: 'Sending an OTP to $phoneNumber');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
