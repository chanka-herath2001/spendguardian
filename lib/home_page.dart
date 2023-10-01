import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendguardian/theme_notifier.dart';

import 'add_transaction_page.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'reports_page.dart';
import 'transaction_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Initially, set the first tab as active

  // Function to handle bottom navigation item tap
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the selected index when a tab is tapped
    });

    // Handle navigation based on the selected tab here
    switch (index) {
      case 0:
        // Handle Home tab
        // You can add your Home page content here
        break;
      case 1:
        // Handle Transactions tab
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => TransactionsPage(),
          ),
        );
        break;
      case 2:
        // Handle Reports tab
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ReportsPage(),
          ),
        );
        break;
      case 3:
        // Handle Profile tab
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final ThemeData currentTheme =
          themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light();

      return Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF1F332C),
          title: Text(
            'Home',
          ),
          titleSpacing: 110.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 220.0,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF1F332C),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                // Background color for the balance container
                child: Container(
                  height: 100.0, // Fixed height
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Total Balance',
                        style: TextStyle(
                          color: isDarkMode
                              ? Color(0xFF0E8388)
                              : Color(0xFF75EEAA),
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: Text(
                          '\$150,000.00',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddTransactionPage(),
                                ),
                              );
                            },
                            child: Text(
                              '   ADD   ',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode
                                    ? Color(0xFFCBE4DE)
                                    : Color(0xFF1F332C),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: isDarkMode
                                  ? Color(0xFF0E8388)
                                  : Color(0xFF75EEAA),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Color(0xFF0E8388) : Color(0xFF044D33),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.arrow_upward,
                  color: Colors.green,
                ),
                title: Text(
                  '\$500  John Doe',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.arrow_downward,
                  color: Colors.red,
                ),
                title: Text(
                  '\$200  Groceries',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.arrow_upward,
                  color: Colors.green,
                ),
                title: Text(
                  '\$300  Jane Smith',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              // Add more recent activity items as needed
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Most interacted with accounts',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Color(0xFF0E8388) : Color(0xFF044D33),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(
                        'assets/images/user-five.webp'), // Replace with John's avatar image
                  ),
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(
                        'assets/images/user-six.jpg'), // Replace with Jane's avatar image
                  ),
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(
                        'assets/images/user_three.jpg'), // Replace with Jane's avatar image
                  ),
                  // Add more recent contact avatars as needed
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            canvasColor: isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF75EEAA),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
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
            selectedItemColor:
                isDarkMode ? Color(0xFFCBE4DE) : Color(0xFF0E8388),
            unselectedItemColor:
                isDarkMode ? Color(0xFF0E8388) : Color(0xFF044D33),
            onTap: _onItemTapped,
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('John Doe'),
                accountEmail: Text('john.doe@example.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color(0xFF044D33),
                  child: Icon(
                    Icons.person,
                    color: Color(0xFF75EEAA),
                    size: 40.0,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Handle item tap
                },
              ),
              ListTile(
                title: Text(
                  'Transactions',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => TransactionsPage(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Report',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Handle item tap
                },
              ),
              ListTile(
                title: Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Handle item tap
                },
              ),
              ListTile(
                title: Text(
                  'Log out',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
              ),
              // Add more items to the drawer as needed
            ],
          ),
        ),
      );
    });
  }
}
