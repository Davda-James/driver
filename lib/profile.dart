import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false; // State to check if editing mode is enabled
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Make the container take the full screen width
        height: double.infinity, // Make the container take the full screen height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey[800]!,
              Colors.grey[400]!,
              Colors.grey[100]!,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 50),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/pfp.png'), // Replace with your image asset
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.camera_alt),
                            color: Colors.white,
                            onPressed: () {
                              // Add camera action here
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                _buildTextField("Name", nameController, isEditing),
                SizedBox(height: 15),
                _buildTextField("Email", emailController, isEditing),
                SizedBox(height: 15),
                _buildTextField("Type something about yourself", bioController, isEditing),
                SizedBox(height: 15),
                _buildTextField("Address", addressController, isEditing),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (isEditing) {
                        // Save changes and exit editing mode
                        isEditing = false;
                      } else {
                        // Enter editing mode
                        isEditing = true;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Background color
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text(isEditing ? 'Save Changes' : 'Edit Profile', style: TextStyle(
                    color: Colors.white
                  ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller, bool enabled) {
    return TextField(
      controller: controller,
      enabled: enabled, // Enable/disable editing based on isEditing state
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
