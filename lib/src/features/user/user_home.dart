// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:emergency_alert_app/src/features/auth/auth_services.dart';
// import 'package:emergency_alert_app/src/features/auth/contact_save_form.dart';
// import 'package:flutter/material.dart';

// class UserHomePage extends StatefulWidget {
//   @override
//   State<UserHomePage> createState() => _UserHomePageState();
// }

// class _UserHomePageState extends State<UserHomePage> {
//   bool _isGlowing = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         // automaticallyImplyLeading: false,
//         backgroundColor: Colors.red,
//         centerTitle: true,
//         foregroundColor: Colors.white,
//         title: const Text(
//           'Emergency Alert',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       drawer: Drawer(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Drawer Header with User Info
//             const UserAccountsDrawerHeader(
//               accountName: Text('User Name'),
//               accountEmail: Text('Email not available'),
//               currentAccountPicture: CircleAvatar(
//                 backgroundColor: Colors.grey,
//                 child: Icon(
//                   Icons.person,
//                   color: Colors.white,
//                   size: 40,
//                 ),
//               ),
//             ),
//             // Body of the Drawer
//             ListTile(
//               leading: const Icon(Icons.contact_page),
//               title: const Text('Contact Screen'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const EmergencyContactsPage()),
//                 );
//               },
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text('Logout'),
//               onTap: () async {
//                 await AuthService.signout(context: context);
//               },
//             ),
//             // Bottom Options: Logout
//           ],
//         ),
//       ),
//       body: Container(
//         // color: Colors.blueGrey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Tap to Send Alert',
//               style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Center(
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _isGlowing = !_isGlowing;
//                   });
//                 },
//                 child: AvatarGlow(
//                   glowColor: Colors.red,
//                   animate: _isGlowing,
//                   duration: const Duration(milliseconds: 2000),
//                   repeat: true,
//                   child: Image.asset(
//                     'assets/sos_button.png',
//                     width: 150,
//                     height: 150,
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             const Text(
//               'Alert send to you emergency contact, Nearest Police Station and Hospital with your current Location',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 18, color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:avatar_glow/avatar_glow.dart';
import 'package:emergency_alert_app/src/features/auth/auth_services.dart';
import 'package:emergency_alert_app/src/features/auth/contact_save_form.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  bool _isGlowing = false;
  bool _isLoggingOut = false; // Loading state for logout

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text(
          'Emergency Alert',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('User Name'),
              accountEmail: Text('Email not available'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.contact_page),
              title: const Text('Contact Screen'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const EmergencyContactsPage()),
                // );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _isLoggingOut
                  ? null
                  : () async {
                      Navigator.pop(context);
                      setState(() {
                        _isLoggingOut = true;
                      });
                      await AuthService.signout(
                        context: context,
                        setLoading: (loading) {
                          setState(() {
                            _isLoggingOut = loading;
                          });
                        },
                      );
                    },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tap to Send Alert',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isGlowing = !_isGlowing;
                    });
                  },
                  child: AvatarGlow(
                    glowColor: Colors.red,
                    animate: _isGlowing,
                    duration: const Duration(milliseconds: 2000),
                    repeat: true,
                    child: Image.asset(
                      'assets/sos_button.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Alert send to your emergency contact, Nearest Police Station and Hospital with your current Location',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
          if (_isLoggingOut)
            Container(
              color: Colors.black38,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
