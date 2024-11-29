import 'package:emergency_alert_app/src/features/help_center/emergency_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyAlertDetailsPage extends StatelessWidget {
  final EmergencyAlert alert;

  EmergencyAlertDetailsPage({required this.alert});

  Future<void> _openMap() async {
    final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${alert.latitude},${alert.longitude}';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${alert.userName} - Details'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Name: ${alert.userName}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Message: ${alert.message}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('DateTime: ${alert.dateTime}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _openMap,
              icon: Icon(Icons.map),
              label: Text('Open in Google Maps'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
