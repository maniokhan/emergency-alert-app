// import 'package:emergency_alert_app/src/common_widgets/common_button.dart';
// import 'package:emergency_alert_app/src/features/auth/login.dart';
// import 'package:emergency_alert_app/src/features/auth/signup.dart';
// import 'package:flutter/material.dart';

// class LoginSignUpPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//       ),
//       extendBodyBehindAppBar: true,
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.6,
//             child: Image.asset(
//               'assets/welcome_image.jpg',
//               fit: BoxFit.cover,
//             ),
//           ),
//           const BackgroundFilter(),
//         ],
//       ),
//     );
//   }
// }

// class BackgroundFilter extends StatelessWidget {
//   const BackgroundFilter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       shaderCallback: (rect) {
//         return LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Colors.white,
//             Colors.white.withOpacity(0.5),
//             Colors.white.withOpacity(0.0),
//           ],
//           stops: const [
//             0.0,
//             0.4,
//             0.6,
//           ],
//         ).createShader(rect);
//       },
//       blendMode: BlendMode.dstOut,
//       child: Container(
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Colors.red.shade200,
//             Colors.red.shade800,
//           ],
//         )),
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               CommonButton(
//                 color: Colors.grey,
//                 text: "LOG IN",
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginPage()),
//                   );
//                 },
//               ),
//               CommonButton(
//                 color: Colors.red,
//                 text: "SIGN UP",
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => SignUpPage()),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:emergency_alert_app/src/common_widgets/common_button.dart';
import 'package:emergency_alert_app/src/features/auth/login.dart';
import 'package:emergency_alert_app/src/features/auth/signup.dart';
import 'package:emergency_alert_app/src/features/help_center/home.dart';
import 'package:flutter/material.dart';

class LoginSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Image.asset(
              'assets/welcome_image.jpg',
              fit: BoxFit.cover,
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
