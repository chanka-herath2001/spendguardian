import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF0A875A),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Builder(
          builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo-no-background.png',
                  height: 200,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF044D33),
                          width: 2.0,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xFF044D33),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF044D33),
                          width: 2.0,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xFF044D33),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _emailAddressController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF044D33),
                          width: 2.0,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xFF044D33),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF044D33),
                          width: 2.0,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xFF044D33),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Signup Successful'),
                      ),
                    );

                    // Navigate back to the login page (main.dart)
                    Navigator.of(context).pop();
                  },
                  child: Text('Signup'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF044D33),
                    onPrimary: Color(0xFF75EEAA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
