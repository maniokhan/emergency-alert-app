import 'package:flutter/material.dart';

class UserHomePage extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text('Emergency Alert',style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text('Tap to Send Alert',style: TextStyle(fontSize: 20,color: Colors.white),),
             SizedBox(height: 30,),
            Center(
              child: Image.asset('assets/sos_button.png', width: 150,height: 150,),
            ),
             SizedBox(height: 30,),
             Text('Alert send to you emergency contact, Nearest Police Station and Hospital with your current Location', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Colors.white),),
          ],
        ),
      ),
    );
  }
}