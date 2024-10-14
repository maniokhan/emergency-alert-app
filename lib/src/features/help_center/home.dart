import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Model for EmergencyAlert
class EmergencyAlert {
  final String userName;
  final String dateTime;

  EmergencyAlert({required this.userName, required this.dateTime});
}

// Dummy data
List<EmergencyAlert> emergencyAlerts = [
  EmergencyAlert(userName: 'John Doe', dateTime: '2024-10-06 14:30:00'),
  EmergencyAlert(userName: 'Jane Smith', dateTime: '2024-10-06 15:00:00'),
  EmergencyAlert(userName: 'Alice Johnson', dateTime: '2024-10-08 00:30:00'),
];

class EmergencyHelpCenterPage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text('Emergency Help Center'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: emergencyAlerts.length,
          itemBuilder: (context, index) {
            final alert = emergencyAlerts[index];
            return Card(
              // color:Colors.white,
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                
                leading: CircleAvatar( 
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.grey),),
                title: Text(alert.userName),
                subtitle: Text(getTimeDifference(alert.dateTime)),
                onTap: () {
                  // Navigate to detail page or show more info
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
