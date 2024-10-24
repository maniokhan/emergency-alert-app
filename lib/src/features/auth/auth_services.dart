// import 'package:emergency_alert_app/src/features/auth/login.dart';
// import 'package:emergency_alert_app/src/features/auth/welcome_page.dart';
// import 'package:emergency_alert_app/src/features/user/user_home.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class AuthService {
//  static Future<void> signup(
//       {required String email,
//       required String password,
//       required BuildContext context}) async {
//     try {
//       await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);

//       await Future.delayed(const Duration(seconds: 1));
//       Navigator.pushReplacement(context,
//           MaterialPageRoute(builder: (BuildContext context) => UserHomePage()));
//     } on FirebaseAuthException catch (e) {
//       String message = '';
//       if (e.code == 'weak-password') {
//         message = 'The password provided is too weak.';
//       } else if (e.code == 'email-already-in-use') {
//         message = 'An account already exists with that email.';
//       }
//       Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.SNACKBAR,
//         backgroundColor: Colors.black54,
//         textColor: Colors.white,
//         fontSize: 14.0,
//       );
//     } catch (e) {}
//   }

//  static Future<void> signin(
//       {required String email,
//       required String password,
//       required BuildContext context}) async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);

//       await Future.delayed(const Duration(seconds: 1));
//       Navigator.pushReplacement(context,
//           MaterialPageRoute(builder: (BuildContext context) => UserHomePage()));
//     } on FirebaseAuthException catch (e) {
//       String message = '';
//       if (e.code == 'invalid-email') {
//         message = 'No user found for that email.';
//       } else if (e.code == 'invalid-credential') {
//         message = 'Wrong password provided for that user.';
//       }
//       Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.SNACKBAR,
//         backgroundColor: Colors.black54,
//         textColor: Colors.white,
//         fontSize: 14.0,
//       );
//     } catch (e) {}
//   }

//  static Future<void> signout({required BuildContext context}) async {
//     await FirebaseAuth.instance.signOut();
//     await Future.delayed(const Duration(seconds: 1));
//     Navigator.pushReplacement(context,
//         MaterialPageRoute(builder: (BuildContext context) => WelcomePage()));
//   }
// }

import 'package:emergency_alert_app/src/features/auth/contact_save_form.dart';
import 'package:emergency_alert_app/src/features/auth/welcome_page.dart';
import 'package:emergency_alert_app/src/features/user/user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  static Future<void> signup(
      {required String email,
      required String password,
      required String userName,
      required BuildContext context,
      required Function setLoading}) async {
    try {
      setLoading(true); // Set loading to true
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));

      setLoading(false); // Set loading to false after process completes
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AddEmergencyContactsPage(
                    uid: userCredential.user!.uid,
                    userName: userName,
                    email: email,
                  )));
    } on FirebaseAuthException catch (e) {
      setLoading(false); // Set loading to false on error
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      setLoading(false); // Set loading to false if catch block is executed
    }
  }

  static Future<void> signin(
      {required String email,
      required String password,
      required BuildContext context,
      required Function setLoading}) async {
    try {
      setLoading(true); // Set loading to true
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await Future.delayed(const Duration(seconds: 1));
      setLoading(false); // Set loading to false after process completes
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => UserHomePage(
                    uid: userCredential.user!.uid,
                  )));
    } on FirebaseAuthException catch (e) {
      setLoading(false); // Set loading to false on error
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      setLoading(false); // Set loading to false if catch block is executed
    }
  }

  static Future<void> signout(
      {required BuildContext context, required Function setLoading}) async {
    try {
      setLoading(true); // Set loading to true
      await FirebaseAuth.instance.signOut();
      await Future.delayed(const Duration(seconds: 1));
      setLoading(false); // Set loading to false after process completes
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => WelcomePage()));
    } on FirebaseAuthException catch (e) {
      setLoading(false); // Set loading to false on error

      Fluttertoast.showToast(
        msg: "Something went wrong!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }
}
