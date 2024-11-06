import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  String? _msgType; // Declare the message  bus variable
  String? _selectedBus;
  final TextEditingController _notificationController =
      TextEditingController(); // Controller for the notification text field
  List<String> _buses = [];
  @override
  void initState() {
    super.initState();
    fetchBusItems(); // Fetch bus items when the widget initializes
  }

  Future<void> fetchBusItems() async {
    try {
      CollectionReference buses =
          FirebaseFirestore.instance.collection('Buses');
      // Fetch all documents in the Buses collection
      QuerySnapshot querySnapshot = await buses.get();

      // Extract document IDs and store them in _bus list
      setState(() {
        _buses = querySnapshot.docs.map((doc) => doc.id).toList();
      });
    } catch (e) {
      print('Error fetching bus items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
        title: const Text("Send Notification"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Dropdown for notification type selection
              // Updated Dropdown with a minimalistic and modern design
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 1.5,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedBus,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    hint: Text(
                      'Select Bus',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedBus = newValue; // Update the selected bus
                      });
                    },
                    items: _buses.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 1.5,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _msgType,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    hint: Text(
                      // Placeholder text
                      'Type of Notification',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _msgType = newValue; // Update the selected bus
                      });
                    },
                    items: <String>['landslide', 'busdelay', 'general']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              SizedBox(height: 20), // Space between dropdown and text box

              // Elevated box for typing notification
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextField(
                  controller: _notificationController,
                  maxLines: 7,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type your notification here...',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),

              SizedBox(height: 20), // Space between text box and submit button

              // Submit button
              ElevatedButton(
                onPressed: (_selectedBus != null &&
                        _msgType != null &&
                        _notificationController.text.isNotEmpty)
                    ? () async {
                        // Handle submit action
                        String notificationText = _notificationController.text;
                        if (notificationText.isNotEmpty && _msgType != null) {
                          CollectionReference notifications = FirebaseFirestore
                              .instance
                              .collection('Notifications');
                          try {
                            await notifications.add({
                              'busId': _selectedBus, // Selected bus ID
                              'message': notificationText, // Message text
                              'type':
                                  _msgType, // Type of the message (e.g., landslide, bus delay, general)
                              'date_time': DateTime.now()
                            });
                            print(
                                'Notification sent: $notificationText for $_selectedBus');
                            // Optionally clear the text field
                            _notificationController.clear();
                            setState(() {
                              _msgType = null;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Notification sent successfully!')),
                            );
                          } catch (e) {
                            print('Error sending notification: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Failed to send notification.')),
                            );
                          }
                        } else {
                          // Show error message if fields are empty
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Please select a notification type and enter a message.')),
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: (_selectedBus != null &&
                          _msgType != null &&
                          _notificationController.text.isNotEmpty)
                      ? Colors.black // Button color when enabled
                      : Colors.grey.shade100, // Button color when disabled
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded edges
                  ),
                ),
                child: Text('Submit',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
