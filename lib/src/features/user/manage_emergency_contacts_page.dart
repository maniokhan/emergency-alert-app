import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_alert_app/src/common_widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:contacts_service/contacts_service.dart';

class ManageEmergencyContactsPage extends StatefulWidget {
  final String uid; // Pass the user ID (UID)
  const ManageEmergencyContactsPage({Key? key, required this.uid})
      : super(key: key);

  @override
  _ManageEmergencyContactsPageState createState() =>
      _ManageEmergencyContactsPageState();
}

class _ManageEmergencyContactsPageState
    extends State<ManageEmergencyContactsPage> {
  List<Map<String, String>> emergencyContacts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEmergencyContacts(); // Fetch contacts when the screen loads
  }

  // Fetch emergency contacts from Firestore
  Future<void> _fetchEmergencyContacts() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      if (userDoc.exists) {
        List<dynamic> contactsFromDB = userDoc['emergency_contacts'] ?? [];
        // Convert the dynamic list to List<Map<String, String>>
        setState(() {
          emergencyContacts = contactsFromDB.map((contact) {
            return {
              'name': contact['name']?.toString() ?? '',
              'number': contact['number']?.toString() ?? '',
            };
          }).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching emergency contacts: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Save the updated contacts list to Firestore
  Future<void> _saveContacts() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .update({
        'emergency_contacts': emergencyContacts,
      });
      Fluttertoast.showToast(
        msg: "Contacts saved successfully!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error saving contacts!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  // Add a new empty contact
  void _addNewContact() {
    setState(() {
      emergencyContacts.add({'name': '', 'number': ''});
    });
  }

  // Remove a contact
  void _removeContact(int index) {
    setState(() {
      emergencyContacts.removeAt(index);
    });
  }

  // Function to pick a contact from phone
  Future<void> _pickContact(int index) async {
    if (await Permission.contacts.request().isGranted) {
      // final Contact? contact = await ContactsService.openDeviceContactPicker();
      // List<Contact> contacts = await FlutterContacts.getContacts();
      // contacts = await FlutterContacts.getContacts(
      //     withProperties: true, withPhoto: true);

      // Get contact with specific ID (fully fetched)
      // Contact? contact = await FlutterContacts.getContact(contacts.first.id);
      final contact = await FlutterContacts.openExternalPick();
      if (contact != null) {
        setState(() {
          emergencyContacts[index]['name'] = contact.displayName ?? '';
          if (contact.phones != null && contact.phones.isNotEmpty) {
            emergencyContacts[index]['number'] = contact.phones.first.number;
          }
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Permission to access contacts is denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Manage Emergency Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewContact,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Emergency Contacts:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: emergencyContacts.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Contact Name',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    emergencyContacts[index]['name'] = value;
                                  },
                                  controller: TextEditingController(
                                    text: emergencyContacts[index]['name'],
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Contact Number',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {
                                    emergencyContacts[index]['number'] = value;
                                  },
                                  controller: TextEditingController(
                                    text: emergencyContacts[index]['number'],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.contacts),
                                      onPressed: () {
                                        _pickContact(index);
                                      },
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => _removeContact(index),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  CommonButton(
                    color: Colors.red,
                    text: "Update Contacts",
                    onTap: () async {
                      if (emergencyContacts.length >= 2) {
                        _saveContacts();
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please add at least 2 valid contacts",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.black54,
                          textColor: Colors.white,
                          fontSize: 14.0,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
