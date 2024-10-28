import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          rippleColor: Colors.black,
          haptic: true,
          tabBorderRadius: 30,
          tabActiveBorder: Border.all(color: Colors.grey, width: 1),
          tabBorder: Border.all(color: Colors.black, width: 1),
          tabShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 8),
          ],
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 250),
          gap: 8,
          activeColor: Colors.white,
          iconSize: 30,
          tabBackgroundColor: Colors.grey.shade500,
          padding: const EdgeInsets.all(16),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.notifications,
              text: 'notification setting',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
          selectedIndex: selectedIndex,
          onTabChange: onTabChange,
        ),
      ),
    );
  }
}
