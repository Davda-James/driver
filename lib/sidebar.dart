import 'package:flutter/material.dart';
import 'home.dart';
import 'Notification.dart';
import 'profile.dart';



class SideBar extends StatelessWidget {
  final Function(int) onItemSelected;

  const SideBar({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:
      ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/pfp.png'), // Add your own image
                ),
                SizedBox(height: 8),
                Text(
                  'User Name',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Location sharing'),
            onTap: () {
              onItemSelected(0);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));

              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Push Notification'),
            onTap: () {
              onItemSelected(2);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationSettingsPage())); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              onItemSelected(3);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Handle logout action here
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
