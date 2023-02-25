import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mlsc_hackathon/SignIn/phone_number.dart';
import 'package:mlsc_hackathon/Helpers/theme.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C9869),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
              child: Column(
                children: [
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "Just a second!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, left: 8),
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "Let's personalize the app for you!",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 216, 217, 216)),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PhoneNumberInput();
                      }));
                    },
                    child: Row(
                      children: [
                        Text(
                          'Continue with phone number',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0C9869),
                            fontSize: 18,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_right,
                          color: kPrimaryColor,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 100),
                child: Image.asset(
                  'Assets/samplelogo.jpg',
                  fit: BoxFit.cover,
                  height: 300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
