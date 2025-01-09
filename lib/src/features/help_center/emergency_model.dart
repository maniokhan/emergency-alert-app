import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyAlert {
  final String sosReqID;
  final String userName;
  final Timestamp dateTime;
  final double latitude;
  final double longitude;
  final String message;

  EmergencyAlert({
    required this.sosReqID,
    required this.userName,
    required this.dateTime,
    required this.latitude,
    required this.longitude,
    required this.message,
  });
}
