import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendguardian/theme_notifier.dart';

import 'add_new_card_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyCardsPage(),
    ),
  );
}

class MyCardsPage extends StatefulWidget {
  @override
  _MyCardsPageState createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF1F332C),
        title: Text('My Cards'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/blackcard.png', // Replace with your credit card image path
              width: 316.0,
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/images/bluecard.png', // Replace with your credit card image path
              width: 316.0,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Handle adding a new card
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNewCardPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: isDarkMode
                    ? Color(0xFFCBE4DE)
                    : Color(
                        0xFF75EEAA), // Change this color to your desired button color
                onPrimary: isDarkMode
                    ? Color(0xFF2E4F4F)
                    : Color(
                        0xFF044D33), // Change this color to your desired text color
                minimumSize: Size(156, 49), // Set width and height
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(23.0), // Set border radius
                ),
              ),
              child: Text(
                'Add new card',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
