import 'package:emergency_alert_app/src/features/auth/contact_save_form.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               SizedBox(height: MediaQuery.of(context).size.height/15,),
                Image.asset('assets/logo.png', width: MediaQuery.of(context).size.width/3),
                SizedBox(height: MediaQuery.of(context).size.height/15,),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                ),
                  obscureText: true,
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                ),
                  obscureText: true,
              ),
              SizedBox(height: 30),
             GestureDetector(
                onTap: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmergencyContactsPage()),
                  );
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width/1.5,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // border: Border.all(color: Colors.red),
                    color: Colors.red
                  ),
                  child: Center(child: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,color: Colors.white),)),
                ),
              ),
              SizedBox(height: 30,),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
