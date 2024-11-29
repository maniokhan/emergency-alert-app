import 'package:emergency_alert_app/src/features/help_center/alert_view.dart';
import 'package:emergency_alert_app/src/features/help_center/emergency_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
  String getTimeDifference(String dateTimeString) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateTime dateTime = dateFormat.parse(dateTimeString);
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  Future<List<EmergencyAlert>> fetchAlerts() async {
    final sosRequestsSnapshot = await FirebaseFirestore.instance
        .collection('SOS-Requests')
        .get();
    final List<EmergencyAlert> alerts = [];

    for (var doc in sosRequestsSnapshot.docs) {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(doc['userID'])
          .get();
      
      final alert = EmergencyAlert(
        sosReqID: doc['sosReqID'],
        userName: userSnapshot['user_name'],
        dateTime: DateTime.now().toString(), // Customize date format if available
        latitude: doc['latitude'],
        longitude: doc['longitude'],
        message: doc['message'],
      );
      alerts.add(alert);
    }
    return alerts;
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
      body: FutureBuilder<List<EmergencyAlert>>(
        future: fetchAlerts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          }
          final alerts = snapshot.data ?? [];
          return ListView.builder(
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              final alert = alerts[index];
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
      ),
    );
  }
}
