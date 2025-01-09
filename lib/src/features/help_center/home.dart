import 'package:emergency_alert_app/src/features/help_center/alert_view.dart';
import 'package:emergency_alert_app/src/features/help_center/emergency_model.dart';
import 'package:emergency_alert_app/src/features/user/hospitals_page.dart';
import 'package:emergency_alert_app/src/features/user/police_stations.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:emergency_alert_app/src/features/auth/auth_services.dart';

class EmergencyHelpCenterPage extends StatefulWidget {
final String uid;
  const EmergencyHelpCenterPage({
    super.key,
    required this.uid,
  });
  @override
  State<EmergencyHelpCenterPage> createState() => _EmergencyHelpCenterPageState();
}

class _EmergencyHelpCenterPageState extends State<EmergencyHelpCenterPage> {
 Map<String, dynamic> userData = {};
 
  bool _isLoggingOut = false;

String getTimeDifference(Timestamp timestamp) {
  try {
    final DateTime dateTime = timestamp.toDate(); // Convert Firestore Timestamp to DateTime
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
      return dateFormat.format(dateTime); // Format as "YYYY-MM-DD HH:MM"
    }
  } catch (e) {
    return 'Invalid date format';
  }
}


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
          // numbers = (userData['emergency_contacts'] as List)
          //     .map((contact) => contact['number'].toString())
          //     .toList();
        }
      });
    }
  }
Stream<List<EmergencyAlert>> fetchAlerts() {
  return FirebaseFirestore.instance
      .collection('SOS-Requests')
      .orderBy('timestamp', descending: true) // Fetch data ordered by timestamp
      .snapshots()
      .asyncMap((snapshot) async {
    final List<EmergencyAlert> alerts = [];

    for (var doc in snapshot.docs) {
      try {
        // Fetch user data from 'users' collection using userID
        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(doc['userID'])
            .get();
print(doc);
        // final timestamp = doc['timestamp']; // Firestore Timestamp
        final alert = EmergencyAlert(
          sosReqID: doc['sosReqID'],
          userName: userSnapshot['user_name'] ?? 'Unknown User', // Safely handle if user_name is missing
          dateTime:doc['timestamp'], // Convert Firestore Timestamp to DateTime
          latitude: doc['latitude'],
          longitude: doc['longitude'],
          message: doc['message'],
        );
        alerts.add(alert);
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }

    return alerts;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text('Emergency Help Center'),
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
            // ListTile(
            //   leading: const Icon(Icons.contact_page),
            //   title: const Text('Contact Screen'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => ManageEmergencyContactsPage(
            //           uid: widget.uid,
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ListTile(
              leading: const Icon(Icons.local_hospital),
              title: const Text('Hospitals'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HospitalsListPage(
                     
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_police),
              title: const Text('Police Stations'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PoliceStationsListPage(
                     
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
     
  body: StreamBuilder<List<EmergencyAlert>>(
  stream: fetchAlerts(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(child: Text('Error loading data: ${snapshot.error}'));
    }

    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(child: Text('No data available'));
    }

    final alerts = snapshot.data!;
    return ListView.builder(
      itemCount: alerts.length,
      itemBuilder: (context, index) {
        final alert = alerts[index];
        print(alert.dateTime); // Debug print to check alert data
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.grey),
            ),
            title: Text(alert.userName),
            subtitle: Text(getTimeDifference(alert.dateTime)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmergencyAlertDetailsPage(alert: alert),
                ),
              );
            },
          ),
        );
      },
    );
  },
)

   
   
   
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
