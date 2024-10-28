import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  String? _selectedBus; // Declare the selected bus variable
  final TextEditingController _notificationController = TextEditingController(); // Controller for the notification text field

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
              Text(
                'Type of Notification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10), // Reduce the space here

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
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedBus = newValue; // Update the selected bus
                      });
                    },
                    items: <String>['Land slide', 'Bus Delay', 'General']
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
                ),
              ),

              SizedBox(height: 20), // Space between text box and submit button

              // Submit button
              ElevatedButton(
                onPressed: () {
                  // Handle submit action
                  String notificationText = _notificationController.text;
                  if (notificationText.isNotEmpty && _selectedBus != null) {
                    // Implement your submission logic here
                    print('Notification sent: $notificationText for $_selectedBus');
                    // Optionally clear the text field
                    _notificationController.clear();
                  } else {
                    // Show error message if fields are empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a notification type and enter a message.')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade500, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded edges
                  ),
                ),
                child: Text('Submit', style: TextStyle(fontSize: 18,color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
