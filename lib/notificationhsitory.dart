import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationHistoryPage(),
    );
  }
}

class NotificationHistoryPage extends StatefulWidget {
  @override
  _NotificationHistoryPageState createState() => _NotificationHistoryPageState();
}

class _NotificationHistoryPageState extends State<NotificationHistoryPage> {
  String? selectedBus;
  String? selectedNotificationType;

  final List<String> buses = ['Bus 1', 'Bus 2', 'Bus 3'];
  final List<String> notificationTypes = ['Land slide', 'Bus delay', 'General'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification History'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Make the column take full width
          children: [
            // Bus Selector
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: DropdownButtonFormField<String>(
                value: selectedBus,
                decoration: InputDecoration(
                  labelText: 'Select Bus',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: buses.map((String bus) {
                  return DropdownMenuItem<String>(
                    value: bus,
                    child: Text(bus),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBus = value;
                  });
                },
              ),
            ),
            // Notification Type Selector
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: DropdownButtonFormField<String>(
                value: selectedNotificationType,
                decoration: InputDecoration(
                  labelText: 'Select Notification Type',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: notificationTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedNotificationType = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20), // Space below the dropdowns
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.grey.shade700, // Button color
              ),
              onPressed: () {
                // Handle the notification retrieval based on selections
                print('Selected Bus: $selectedBus');
                print('Selected Notification Type: $selectedNotificationType');
              },
              child: Text(
                'Get Notifications',
                style: TextStyle(fontSize: 18,color: Colors.white), // Increased font size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
