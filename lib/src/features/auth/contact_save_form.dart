import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:emergency_alert_app/src/common_widgets/common_button.dart';
import 'package:emergency_alert_app/src/features/user/user_home.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEmergencyContactsPage extends StatefulWidget {
  final String uid;
  final String userName;
  final String email;

  const AddEmergencyContactsPage(
      {super.key,
      required this.uid,
      required this.userName,
      required this.email});

  @override
  _AddEmergencyContactsPageState createState() =>
      _AddEmergencyContactsPageState();
}

class _AddEmergencyContactsPageState extends State<AddEmergencyContactsPage> {
  List<Map<String, String>> emergencyContacts = [
    {"name": "", "number": ""},
    {"name": "", "number": ""}
  ]; // Two default contact fields

  bool _isSaving = false;

  void addNewContact() {
    setState(() {
      emergencyContacts.add({"name": "", "number": ""});
    });
  }

  void removeContact(int index) {
    setState(() {
      emergencyContacts.removeAt(index);
    });
  }

  // Function to request contact permission and pick a contact
  Future<void> _pickContact(int index) async {
    if (await Permission.contacts.request().isGranted) {
      // Get the contact from the phone's contact list
      List<Contact> contacts = await FlutterContacts.getContacts();
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);

      // Get contact with specific ID (fully fetched)
      // Contact? contact = await FlutterContacts.getContact(contacts.first.id);
      final contact = await FlutterContacts.openExternalPick();
      if (contact != null) {
        setState(() {
          emergencyContacts[index]['name'] = contact.displayName ?? '';
          if (contact.phones != null && contact.phones.isNotEmpty) {
            emergencyContacts[index]['number'] =
                contact.phones.first.number ?? '';
          }
        });
      }
    } else {
      // Handle permission denial
      Fluttertoast.showToast(
        msg: 'Permission to access contacts is denied',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  // Function to validate and save contacts to Firestore
  Future<void> _saveContacts() async {
    // Check if at least two contacts are filled
    if (emergencyContacts
            .where((c) => c['name']!.isNotEmpty && c['number']!.isNotEmpty)
            .length <
        2) {
      Fluttertoast.showToast(
        msg: 'Please add at least 2 valid contacts',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    // Prepare contact data for Firestore
    Map<String, dynamic> userData = {
      'uid': widget.uid,
      'email': widget.email,
      'user_name': widget.userName,
      'emergency_contacts': emergencyContacts
          .where((contact) =>
              contact['name']!.isNotEmpty && contact['number']!.isNotEmpty)
          .toList(),
    };

    try {
      // Save user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .set(userData);

      // Navigate to the user home page after saving
      setState(() {
        _isSaving = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => UserHomePage(
                  uid: widget.uid,
                )),
      );
    } catch (e) {
      // Handle Firestore errors
      print(e);
      Fluttertoast.showToast(
        msg: 'Failed to save contacts. Please try again.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Save Emergency Contacts'),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Please provide the names and phone numbers of your emergency contacts.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),

                  // Dynamically add TextFields for each contact
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: emergencyContacts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Contact Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onChanged: (value) {
                                emergencyContacts[index]['name'] = value;
                              },
                              controller: TextEditingController(
                                text: emergencyContacts[index]['name'],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Contact Number',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                emergencyContacts[index]['number'] = value;
                              },
                              controller: TextEditingController(
                                text: emergencyContacts[index]['number'],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon:
                                      Icon(Icons.contacts, color: Colors.blue),
                                  onPressed: () {
                                    _pickContact(
                                        index); // Pick contact from phone
                                  },
                                ),
                                if (emergencyContacts.length > 1)
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle,
                                        color: Colors.red),
                                    onPressed: () => removeContact(index),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  // Add Contact Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: addNewContact,
                      icon: Icon(Icons.add, color: Colors.green),
                      label: Text('Add Another Contact'),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Save Contacts Button
                  CommonButton(
                    color: Colors.red,
                    text: "SAVE CONTACTS",
                    onTap: _saveContacts,
                  ),
                ],
              ),
            ),
          ),
          if (_isSaving)
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
