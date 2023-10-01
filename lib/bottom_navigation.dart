import 'package:flutter/material.dart';
import 'package:spendguardian/profile_page.dart';
import 'package:spendguardian/reports_page.dart';

import 'home_page.dart';
import 'transaction_page.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0; // Initially, set the first tab as active

  // Function to handle bottom navigation item tap
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the selected index when a tab is tapped
    });

    // Handle navigation based on the selected tab here
    switch (index) {
      case 0:
        // Navigate to Home Page (homepage.dart)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        // Navigate to Transactions Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TransactionsPage()),
        );
        break;
      case 2:
        // Navigate to Reports Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ReportsPage()),
        );
        break;
      case 3:
        // Navigate to Profile Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Color(
            0xFF75EEAA), // Set the background color of the BottomNavigationBar
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex, // Use the current index
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Color(0xFF0E8388), // Set the selected item color
        unselectedItemColor: Color(0xFF044D33), // Set the unselected item color
        onTap: _onItemTapped, // Use the onTap function
      ),
    );
  }
}
