import 'package:flutter/material.dart';

class PoliceStationsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest Police Stations'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildPoliceStationCard(
                context,
                stationName: "Jamshoro Police Station",
                address: "Jamshoro City, Jamshoro, Sindh",
                phoneNumber: "----",
              ),
              SizedBox(height: 16),
              _buildPoliceStationCard(
                context,
                stationName: "Police Station Kotri.",
                address: "Kotri City Sindh",
                phoneNumber: "(022) 3875432",
              ),
              SizedBox(height: 16),
              _buildPoliceStationCard(
                context,
                stationName: "Police Station Site Kotri",
                address: "Site Area Kotri Sindh",
                phoneNumber: "----",
              ),
              SizedBox(height: 16),
              _buildPoliceStationCard(
                context,
                stationName: "KK Basti Police Station",
                address: "KK Basti  Kotri Sindh",
                phoneNumber: "---",
              ),
              SizedBox(height: 16),
              _buildPoliceStationCard(
                context,
                stationName: "Cantt Police Station ",
                address: "Saddar Bazar, Cantt Area Doctors Colony, Hyderabad, Sindh",
                phoneNumber: "---",
              ),
              SizedBox(height: 16),
              _buildPoliceStationCard(
                context,
                stationName: "Police Station B-Section",
                address: "Latifabad Unit 6 Latifabad, Hyderabad, Sindh 71000",
                phoneNumber: "---",
              ),
              SizedBox(height: 16),
              _buildPoliceStationCard(
                context,
                stationName: "Bhitai Nagar Police Station",
                address: "11 Bhitai Nagar Rd, Sachalabad Bhittai Nagar Qasimabad, Hyderabad, Sindh",
                phoneNumber: "---",
              ),
              SizedBox(height: 16),
              _buildPoliceStationCard(
                context,
                stationName: "Baldia Police Station",
                address: "Hyderabad, Sindh",
                phoneNumber: "---",
              ),
              SizedBox(height: 16),
              _buildPoliceStationCard(
                context,
                stationName: "Police Station , Naseem Nagar Choki",
                address: "Wadhu Wah Rd, Qasimabad, Hyderabad, Sindh",
                phoneNumber: "0300 3018711",
              ),
              SizedBox(height: 16),
              _buildPoliceStationCard(
                context,
                stationName: "Madadgar 15 Qasimabad",
                address: "Nasim Nagar Rd, Phase 1 Qasimabad, Hyderabad, Sindh",
                phoneNumber: "0300 3018711",
              ),
              SizedBox(height: 16),
              _buildPoliceStationCard(
                context,
                stationName: "Police Station , Naseem Nagar Choki",
                address: "Wadhu Wah Rd, Qasimabad, Hyderabad, Sindh",
                phoneNumber: "0300 3018711",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPoliceStationCard(BuildContext context,
      {required String stationName,
      required String address,
      required String phoneNumber}) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.red.shade100,
                child: Icon(Icons.local_police, size: 40, color: Colors.red,),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                stationName,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.red,),
              title: Text(
                'Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(address, style: TextStyle(fontSize: 16)),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.red,),
              title: Text(
                'Phone Number',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(phoneNumber, style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
