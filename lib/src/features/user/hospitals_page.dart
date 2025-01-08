import 'package:flutter/material.dart';

class HospitalsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest Hospitals'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHospitalCard(
                context,
                hospitalName: "Civil Hospital Lumhs Jamshoro",
                address: " Liaquat University of Medical and Health Sciences Jamshoro, Sindh",
                phoneNumber: "(022) 9213395",
              ),
              SizedBox(height: 16),
              _buildHospitalCard(
                context,
                hospitalName: "Asif General Hospital",
                address: "Opposite Yasir Hotel Jamshoro",
                phoneNumber: "----",
              ),
              SizedBox(height: 16),
              _buildHospitalCard(
                context,
                hospitalName: "Bakhtawar General Hospital",
                address: "789 Sunshine Blvd, Sunnytown",
                phoneNumber: "---",
              ),
              SizedBox(height: 16),
              _buildHospitalCard(
                context,
                hospitalName: "BMC Hospital Jamshoro",
                address: "LUMHS Jamshoro",
                phoneNumber: "---",
              ),
              SizedBox(height: 16),
              _buildHospitalCard(
                context,
                hospitalName: "BMC Hospital Jamshoro",
                address: "LUMHS Jamshoro",
                phoneNumber: "---",
              ),
              SizedBox(height: 16),
              _buildHospitalCard(
                context,
                hospitalName: "Jijal Maa Hospital",
                address: "Wadhu Wah Qaimabad Hyderabad Sindh",
                phoneNumber: "(022) 2656322",
              ),
              SizedBox(height: 16),
              _buildHospitalCard(
                context,
                hospitalName: "Shafay Hospital",
                address: "Nasim Nagar Qasimabad, Hyderabad, Sindh",
                phoneNumber: "(022) 2652104",
              ),
              SizedBox(height: 16),
              _buildHospitalCard(
                context,
                hospitalName: "National Institute of Cardiovascular Diseases (NICVD) Hyderabad",
                address: "Wadhu Wah Rd, Qasimabad, Hyderabad, Sindh 71000",
                phoneNumber: " (021) 99201271",
              ),
              SizedBox(height: 16),
              _buildHospitalCard(
                context,
                hospitalName: "Civil Hospital Hyderabad",
                address: "Hyderabad Sindh",
                phoneNumber: "0310 3890164",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHospitalCard(BuildContext context,
      {required String hospitalName,
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
                child: Icon(Icons.local_hospital, size: 40, color: Colors.red),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                hospitalName,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.red),
              title: Text(
                'Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(address, style: TextStyle(fontSize: 16)),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.red),
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
