import 'package:emergency_alert_app/src/features/auth/welcome_page.dart';
import 'package:emergency_alert_app/src/features/user/user_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Check auth state
    Timer(Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => WelcomePage()));
        } else {
           if (user.email == 'admin@helpcenter.com') {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => EmergencyHelpCenterPage(
                        uid: user.uid,
                      )),
              (route) => false,
            );
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => UserHomePage(
                      uid: user.uid,
                    )));
          }
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //     builder: (context) => UserHomePage(
          //           uid: user.uid,
          //         )));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blueGrey,
        child: Center(
          child: Image.asset(
            'assets/logo.png',
            width: MediaQuery.of(context).size.width / 1.5,
          ),
        ),
      ),
    );
  }
}
