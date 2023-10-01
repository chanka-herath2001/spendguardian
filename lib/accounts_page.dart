import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_account_page.dart';
import 'theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: AccountsPage(),
    ),
  );
}

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF1F332C),
        title: Text('Accounts'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 100.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 297,
                  height: 132,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF75EEAA),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset(
                            'assets/images/user-five.webp', // Replace with your friend's image asset
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'Wade Wilson', // Replace with friend's name
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? Color(0xFFCBE4DE)
                                : Color(0xFF044D33)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: 297,
                  height: 132,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF75EEAA),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset(
                            'assets/images/user_three.jpg', // Replace with your friend's image asset
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'Jane Doe', // Replace with friend's name
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? Color(0xFFCBE4DE)
                                : Color(0xFF044D33)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Add new account logic
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAccountPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: isDarkMode ? Color(0xFFCBE4DE) : Color(0xFF044D33),
                    onPrimary:
                        isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF75EEAA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                    minimumSize: Size(156, 49),
                  ),
                  child: Text(
                    'Add New Account',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
