import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'reports_page.dart';
import 'theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: TransactionsPage(),
    ),
  );
}

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  int _currentIndex = 1; // Initially, set the second tab as active

  // Function to handle bottom navigation item tap
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        break;
      case 1:
        //  (current page)
        break;
      case 2:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ReportsPage(),
          ),
        );
        break;
      case 3:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
        break;
    }
  }

  final _formKey = GlobalKey<FormState>();
  String selectedCard = 'HNB';
  String selectedRecipient = 'John Doe';
  DateTime selectedDate = DateTime.now();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  List<String> cards = ['HNB', 'NDB', 'NTB'];
  List<String> recipients = ['John Doe', 'Bob Smith', 'Ryan Tan'];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final ThemeData currentTheme =
          themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF1F332C),
          title: Text('Transactions'),
          titleSpacing: 77.0,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Image.asset(
                'assets/images/logo-no-background.png',
                width: 40.0,
                height: 40.0,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 16.0),
                  ListTile(
                    title: Text('Date'),
                    subtitle: Text(
                      '${selectedDate.toLocal()}'.split(' ')[0],
                      style: TextStyle(fontSize: 20.0),
                    ),
                    trailing: Icon(
                      Icons.calendar_today,
                      color: isDarkMode ? Color(0xFF0E8388) : Color(0xFF044D33),
                    ),
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != selectedDate) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                  ListTile(
                    title: Text('Select Card'),
                    subtitle: DropdownButton<String>(
                      value: selectedCard,
                      onChanged: (value) {
                        setState(() {
                          selectedCard = value!;
                        });
                      },
                      items: cards.map((card) {
                        return DropdownMenuItem<String>(
                          value: card,
                          child: Text(card),
                        );
                      }).toList(),
                    ),
                  ),
                  ListTile(
                    title: Text('Select Recipient'),
                    subtitle: DropdownButton<String>(
                      value: selectedRecipient,
                      onChanged: (value) {
                        setState(() {
                          selectedRecipient = value!;
                        });
                      },
                      items: recipients.map((recipient) {
                        return DropdownMenuItem<String>(
                          value: recipient,
                          child: Text(recipient),
                        );
                      }).toList(),
                    ),
                  ),
                  ListTile(
                    title: Text('Amount'),
                    subtitle: TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        // Add more validation if needed
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Note (Optional)'),
                    subtitle: TextFormField(
                      controller: noteController,
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, handle form submission
                          // For example, you can send the data to a backend server
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary:
                            isDarkMode ? Color(0xFF0E8388) : Color(0xFF044D33),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode
                              ? Color(0xFFCBE4DE)
                              : Color(0xFF75EEAA),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            canvasColor: isDarkMode
                ? Color(0xFF2E4F4F)
                : Color(
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
            selectedItemColor:
                isDarkMode ? Color(0xFFCBE4DE) : Color(0xFF0E8388),
            unselectedItemColor: isDarkMode
                ? Color(0xFF0E8388)
                : Color(0xFF044D33), // Set the unselected item color
            onTap: _onItemTapped, // Use the onTap function
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('John Doe'), // User's name
                accountEmail: Text('john.doe@example.com'), // User's email
                currentAccountPicture: CircleAvatar(
                  // User's icon
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
                    color: Colors.green, // Change the text color to red
                    fontSize: 18, // Change the font size to 18
                    fontWeight: FontWeight.bold, // Apply bold font weight
                  ),
                ),
                onTap: () {
                  // Handle item tap
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
                    color: Colors.green, // Change the text color to red
                    fontSize: 18, // Change the font size to 18
                    fontWeight: FontWeight.bold, // Apply bold font weight
                  ),
                ),
                onTap: () {
                  // Navigate to the login page when logging out
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
                    color: Colors.green, // Change the text color to red
                    fontSize: 18, // Change the font size to 18
                    fontWeight: FontWeight.bold, // Apply bold font weight
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
                    color: Colors.green, // Change the text color to red
                    fontSize: 18, // Change the font size to 18
                    fontWeight: FontWeight.bold, // Apply bold font weight
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
                    color: Colors.red, // Change the text color to red
                    fontSize: 18, // Change the font size to 18
                    fontWeight: FontWeight.bold, // Apply bold font weight
                  ),
                ),
                onTap: () {
                  // Navigate to the login page when logging out
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
