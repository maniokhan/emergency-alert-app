import 'package:emergency_alert_app/src/features/auth/login.dart';
import 'package:emergency_alert_app/src/features/auth/signup.dart';
import 'package:flutter/material.dart';

class LoginSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Emergency Alert App'),
      // ),
      body: Container(
        color: Colors.blueGrey,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 7,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.8,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/welcome_image.png'))),
            ),
            // SizedBox(height: MediaQuery.of(context).size.height / 15
            // ,),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.5,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: Colors.red),
                child: Center(
                    child: Text(
                  'Login',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white),
                )),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => LoginPage()),
            //     );
            //   },
            //   child: Text('Login'),
            // ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.5,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // border: Border.all(color: Colors.red),
                    color: Colors.white),
                child: Center(
                    child: Text(
                  'Sign Up',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.red),
                )),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => SignUpPage()),
            //     );
            //   },
            //   child: Text('Sign Up'),
            // ),
          ],
        ),
      ),
    );
  }
}
