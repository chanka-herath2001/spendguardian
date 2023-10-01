import 'package:flutter/material.dart';

import 'home_page.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Temporary username and password
  final String _temporaryUsername = 'john';
  final String _temporaryPassword = '1234';

  void _login() {
    // Navigate to the home page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF0A875A),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                controller: _usernameController,
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text(' Login '),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF75EEAA),
                onPrimary: Color(0xFF044D33),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignupPage(),
                  ),
                );
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
        ),
      ),
    );
  }
}
