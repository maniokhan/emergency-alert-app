import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_alert_app/src/features/auth/auth_services.dart';
// import 'package:emergency_alert_app/src/features/auth/contact_save_form.dart';
import 'package:emergency_alert_app/src/features/user/manage_emergency_contacts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:sms_advanced/sms_advanced.dart';

class UserHomePage extends StatefulWidget {
  final String uid;
  const UserHomePage({
    super.key,
    required this.uid,
  });
  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  bool _isGlowing = false;
  bool _isLoggingOut = false;
  Map<String, dynamic> userData = {};
  List<String> numbers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    Map<String, dynamic>? user = await retrieveUserData(widget.uid);
    if (user!.isNotEmpty) {
      setState(() {
        userData = user;
        if (userData.containsKey('emergency_contacts') &&
            userData['emergency_contacts'] is List) {
          numbers = (userData['emergency_contacts'] as List)
              .map((contact) => contact['number'].toString())
              .toList();
        }
      });
    }
  }

  // _sendSMS() async {
  //   if (numbers.isEmpty) {
  //     Fluttertoast.showToast(
  //       msg:
  //           "Please add some emergency contacts before sending an SOS message.",
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.SNACKBAR,
  //       backgroundColor: Colors.black54,
  //       textColor: Colors.white,
  //       fontSize: 14.0,
  //     );
  //   } else {
  //     if (await Permission.sms.request().isGranted) {
  //       await sendSMS(
  //           message: "Test Message From Flutter App",
  //           recipients: numbers,
  //           sendDirect: true);
  //     }
  //   }
  // }

  Future<void> _sendSOS() async {
    // Check if emergency contacts are available
    if (numbers.isEmpty) {
      Fluttertoast.showToast(
        msg:
            "Please add some emergency contacts before sending an SOS message.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } else {
      // Request location permission and get user's location
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission = await Geolocator.checkPermission();

      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition();

      // Create Google Maps link with current location
      String mapsLink =
          "https://maps.google.com/?q=${position.latitude},${position.longitude}";
      String sosMessage = "SOS! I need help. My current location: $mapsLink";

      // Check SMS permission and send message
      if (await Permission.sms.request().isGranted) {
        setState(() {
          _isGlowing = true;
        });
        await sendSMS(
          message: sosMessage,
          recipients: numbers,
          sendDirect: true,
        );
        String sosID = const Uuid().v1();
        await FirebaseFirestore.instance
            .collection('SOS-Requests')
            .doc(sosID)
            .set({
          "sosReqID": sosID,
          "userID": widget.uid,
          "latitude": position.latitude,
          "longitude": position.longitude,
          "message": sosMessage,
        });
        ;
        Fluttertoast.showToast(
          msg: "SOS message sended successfully!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        Future.delayed(const Duration(seconds: 2));
        setState(() {
          _isGlowing = false;
        });
      }
    }
  }

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
            UserAccountsDrawerHeader(
              accountName: Text(userData['user_name'] ?? 'User Name'),
              accountEmail: Text(userData['email'] ?? 'Email not available'),
              currentAccountPicture: const CircleAvatar(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManageEmergencyContactsPage(
                      uid: widget.uid,
                    ),
                  ),
                );
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
                  onTap: () async {
                    await _sendSOS();
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

  Future<Map<String, dynamic>?> retrieveUserData(String uid) async {
    try {
      // Reference to the user document in Firestore
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        // Convert document data into a map and return it
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        return userData; // Return the user data
      } else {
        print("No user data found for this UID.");
        return null;
      }
    } catch (e) {
      print("Error retrieving user data: $e");
      return null; // Return null if there's an error
    }
  }
}
