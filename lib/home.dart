import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'bottomnavigationbar.dart';
import 'Notification.dart';
import 'profile.dart';
import 'notificationhsitory.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // State variable to track the selected index
  String _selectedBus = 'Bus A'; // Default bus selection

  void _onSidebarItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate based on the selected tab
    switch (index) {
      case 0:
      // Navigate to Home or refresh the current page
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationSettingsPage()),
        );
        break;

      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  void _shareLocation() {
    // Implement location sharing logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sharing location...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'),
        actions: [IconButton(
          icon: Icon(Icons.history, color: Colors.black), // Back arrow icon
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationHistoryPage()));
             // Navigate back to the previous page
          },
        ),
        ],

      ),
      drawer: SideBar(
        onItemSelected: _onSidebarItemSelected,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Dropdown for bus selection
              Text(
                'Select Bus',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),

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
                        _selectedBus = newValue!;
                      });
                    },
                    items: <String>['Bus A', 'Bus B', 'Bus C']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      'Choose a time slot',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),

              // Center the button with more styling
              ElevatedButton(
                onPressed: _shareLocation,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black, // Button color
                ),
                child: Text(
                  'Share My Location',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
      ),
    );
  }
}
