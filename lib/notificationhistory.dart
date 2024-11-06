import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
  _NotificationHistoryPageState createState() =>
      _NotificationHistoryPageState();
}

class _NotificationHistoryPageState extends State<NotificationHistoryPage> {
  String? selectedBus;
  String? selectedNotificationType;
  List<Map<String, dynamic>> notifications = [];
  int? expandedIndex;
  Future<void> fetchNotifications() async {
    if (selectedBus != null && selectedNotificationType != null) {
      try {
        // Query Firestore for notifications matching the selected bus and type
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Notifications')
            .where('busId', isEqualTo: selectedBus)
            .where('type', isEqualTo: selectedNotificationType)
            .get();

        // Map Firestore documents to a list of notifications
        setState(() {
          notifications = querySnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
        });
        print(notifications);
      } catch (e) {
        print('Error fetching notifications: $e');
      }
    }
  }

  final List<String> buses = ['BUS(A)', 'BUS(B)', 'BUS(C)'];
  final List<String> notificationTypes = ['landslide', 'busdelay', 'general'];
  void toggleExpand(int index) {
    setState(() {
      expandedIndex = (expandedIndex == index) ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification History'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          // Dismiss expanded message when tapping outside
          setState(() {
            expandedIndex = null;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Make the column take full width
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
                  fetchNotifications();
                  print('Selected Bus: $selectedBus');
                  print(
                      'Selected Notification Type: $selectedNotificationType');
                },
                child: Text(
                  'Get Notifications',
                  style: TextStyle(
                      fontSize: 18, color: Colors.white), // Increased font size
                ),
              ),
              SizedBox(height: 20),
              // Display Notifications
              Expanded(
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    bool isExpanded = expandedIndex ==
                        index; // Check if this message is expanded

                    return GestureDetector(
                      onTap: () {
                        toggleExpand(index); // Toggle expand on tap
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            ListTile(
                              title:
                                  Text(notification['message'] ?? 'No message'),
                              subtitle: Text(
                                'Date: ${notification['date_time'] != null ? DateFormat('yyyy-MM-dd HH:mm').format((notification['date_time'] as Timestamp).toDate()) : 'Unknown date'}',
                              ),
                            ),
                            if (isExpanded) // Show the full message only when expanded
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  notification['message'] ?? 'No message',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
