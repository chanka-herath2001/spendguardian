import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: AddNewCardPage(),
    ),
  );
}

class AddNewCardPage extends StatefulWidget {
  @override
  _AddNewCardPageState createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final _formKey = GlobalKey<FormState>();
  String? _cardNumber;
  String? _expirationDate;
  String? _cvv;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF1F332C),
        title: Text('Add New Card'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 100.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/bluecard.png',
                  width: 316.0,
                ),
                SizedBox(height: 20.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Card Number'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter card number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _cardNumber = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Expiration Date'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter expiration date';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _expirationDate = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'CVV'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter CVV';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _cvv = value;
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: isDarkMode
                              ? Color(0xFF0E8388)
                              : Color(0xFF044D33),
                          onPrimary: isDarkMode
                              ? Color(0xFFCBE4DE)
                              : Color(0xFF75EEAA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
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
