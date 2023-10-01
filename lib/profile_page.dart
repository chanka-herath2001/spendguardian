import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'accounts_page.dart';
import 'edit_profile_page.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'my_cards_page.dart';
import 'theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: ProfilePage(),
    ),
  );
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 3;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void _toggleThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = !isDarkMode;
    });
    prefs.setBool('isDarkMode', isDarkMode);
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed('/home');
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed('/transactions');
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed('/reports');
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF1F332C),
        title: Text('Profile'),
        titleSpacing: 102,
        actions: [
          Consumer<ThemeNotifier>(
            builder: (context, themeNotifier, child) {
              return Switch(
                value: themeNotifier.isDarkMode,
                onChanged: (value) {
                  themeNotifier.toggleTheme();
                  _saveThemeMode(themeNotifier.isDarkMode);
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 100.0),
        child: ListView(
          children: [
            ListTile(
              title: Center(
                child: CircleAvatar(
                  backgroundColor:
                      isDarkMode ? Color(0xFF0E8388) : Color(0xFF044D33),
                  child: Icon(
                    Icons.person,
                    color: isDarkMode
                        ? Color(
                            0xFFCBE4DE) // Change the color for the icon in dark mode
                        : Color(
                            0xFF75EEAA), // Change the color for the icon in light mode
                    size: 70.0,
                  ),
                  radius: 40.0,
                ),
              ),
            ),
            ListTile(
              title: Center(
                child: SizedBox(
                  width: 253.0,
                  height: 52.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        isDarkMode ? Color(0xFF0E8388) : Color(0xFF044D33),
                      ),
                    ),
                    child: Text('Edit Profile',
                        style: TextStyle(
                          color: isDarkMode
                              ? Color(
                                  0xFFCBE4DE) // Change the color for the icon in dark mode
                              : Color(0xFF75EEAA),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Center(
                child: SizedBox(
                  width: 253.0,
                  height: 52.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyCardsPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        isDarkMode ? Color(0xFF0E8388) : Color(0xFF044D33),
                      ),
                    ),
                    child: Text(
                      'My Cards',
                      style: TextStyle(
                        color: isDarkMode
                            ? Color(
                                0xFFCBE4DE) // Change the color for the icon in dark mode
                            : Color(0xFF75EEAA),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Center(
                child: SizedBox(
                  width: 253.0,
                  height: 52.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountsPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        isDarkMode ? Color(0xFF0E8388) : Color(0xFF044D33),
                      ),
                    ),
                    child: Text(
                      'Accounts',
                      style: TextStyle(
                        color: isDarkMode
                            ? Color(
                                0xFFCBE4DE) // Change the color for the icon in dark mode
                            : Color(0xFF75EEAA),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Center(
                child: SizedBox(
                  width: 253.0,
                  height: 52.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text('Log Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
                ),
              ),
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
          selectedItemColor: isDarkMode ? Color(0xFFCBE4DE) : Color(0xFF0E8388),
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
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
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
                Navigator.of(context).pop();
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
              onTap: () {},
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
              onTap: () {},
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
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }
}
