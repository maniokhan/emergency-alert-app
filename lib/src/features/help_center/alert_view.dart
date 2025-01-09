// import 'package:emergency_alert_app/src/features/help_center/emergency_model.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class EmergencyAlertDetailsPage extends StatelessWidget {
//   final EmergencyAlert alert;

//   EmergencyAlertDetailsPage({required this.alert});

//   Future<void> _openMap() async {
//     final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${alert.latitude},${alert.longitude}';
//     if (await canLaunch(googleMapsUrl)) {
//       await launch(googleMapsUrl);
//     } else {
//       throw 'Could not open the map.';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${alert.userName} - Details'),
//         backgroundColor: Colors.red,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('User Name: ${alert.userName}', style: TextStyle(fontSize: 18)),
//             SizedBox(height: 8),
//             Text('Message: ${alert.message}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 8),
//             Text('DateTime: ${alert.dateTime}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 16),
//             ElevatedButton.icon(
//               onPressed: _openMap,
//               icon: Icon(Icons.map),
//               label: Text('Open in Google Maps'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:emergency_alert_app/src/features/help_center/emergency_model.dart';

// class EmergencyAlertDetailsPage extends StatelessWidget {
//   final EmergencyAlert alert;

//   EmergencyAlertDetailsPage({required this.alert});

//   Future<void> _openMap() async {
//     final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${alert.latitude},${alert.longitude}';
//     if (await canLaunch(googleMapsUrl)) {
//       await launch(googleMapsUrl);
//     } else {
//       throw 'Could not open the map.';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Alert Details'),
//         backgroundColor: Colors.red,
//         foregroundColor: Colors.white,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Card(
//           elevation: 8.0,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: CircleAvatar(
//                     radius: 40,
//                     backgroundColor: Colors.red.shade100,
//                     child: Icon(Icons.person, size: 40, color: Colors.red),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Center(
//                   child: Text(
//                     alert.userName,
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Divider(),
//                 ListTile(
//                   leading: Icon(Icons.message, color: Colors.red),
//                   title: Text(
//                     'Message',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(alert.message, style: TextStyle(fontSize: 16)),
//                 ),
//                 Divider(),
//                 ListTile(
//                   leading: Icon(Icons.access_time, color: Colors.red),
//                   title: Text(
//                     'Date & Time',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(alert.dateTime, style: TextStyle(fontSize: 16)),
//                 ),
//                 Spacer(),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton.icon(
//                     onPressed: _openMap,
//                     icon: Icon(Icons.map, color: Colors.white,),
//                     label: Text('Open in Google Maps', style: TextStyle(color: Colors.white,),),
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       backgroundColor: Colors.red,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:emergency_alert_app/src/features/help_center/emergency_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart'; // Required for coordinates
// import 'package:url_launcher/url_launcher.dart'; // For opening Google Maps

// class EmergencyAlertDetailsPage extends StatelessWidget {
//   final EmergencyAlert alert;

//   EmergencyAlertDetailsPage({required this.alert});

//   Future<void> _openDirections() async {
//     final googleMapsUrl = 'https://www.google.com/maps/dir/?api=1&origin=${alert.latitude},${alert.longitude}';
//     if (await canLaunch(googleMapsUrl)) {
//       await launch(googleMapsUrl);
//     } else {
//       throw 'Could not open directions in Google Maps.';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(alert.message);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Alert Details'),
//         backgroundColor: Colors.red,
//         foregroundColor: Colors.white,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: CircleAvatar(
//                 radius: 40,
//                 backgroundColor: Colors.red.shade100,
//                 child: Icon(Icons.person, size: 40, color: Colors.red),
//               ),
//             ),
//             SizedBox(height: 16),
//             Center(
//               child: Text(
//                 alert.userName,
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: 16),
//             // Divider(),
//             // ListTile(
//             //   leading: Icon(Icons.message, color: Colors.red),
//             //   title: Text(
//             //     'Message',
//             //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             //   ),
//             //   subtitle: Text(alert.message, style: TextStyle(fontSize: 16)),
//             // ),
//             Divider(),
//             ListTile(
//               leading: Icon(Icons.access_time, color: Colors.red),
//               title: Text(
//                 'Date & Time',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(alert.dateTime, style: TextStyle(fontSize: 16)),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               // height: 500, // Height for the map
//               child: FlutterMap(
//                 options: MapOptions(
//                   center: LatLng(alert.latitude, alert.longitude),
//                   zoom: 13.0,
//                 ),
//                 children: [
//                   TileLayer(
//                     urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                     subdomains: ['a', 'b', 'c'],
//                   ),
//                   MarkerLayer(
//                     markers: [
//                       Marker(
//                         width: 80.0,
//                         height: 80.0,
//                         point: LatLng(alert.latitude, alert.longitude),
//                         builder: (ctx) => Icon(
//                           Icons.location_pin,
//                           color: Colors.red,
//                           size: 40,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
            
//             // SizedBox(
//             //   width: double.infinity,
//             //   child: ElevatedButton.icon(
//             //     onPressed: () {
//             //       _openMap();
//             //     },
//             //     icon: Icon(Icons.map, color: Colors.white),
//             //     label: Text(
//             //       'Open in Google Maps',
//             //       style: TextStyle(color: Colors.white),
//             //     ),
//             //     style: ElevatedButton.styleFrom(
//             //       padding: EdgeInsets.symmetric(vertical: 16),
//             //       backgroundColor: Colors.red,
//             //       shape: RoundedRectangleBorder(
//             //         borderRadius: BorderRadius.circular(8),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _openDirections,
//         backgroundColor: Colors.red,
//         child: Icon(Icons.directions),
//       ),
//     );
//   }
// }
