import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: AddAccountPage(),
    ),
  );
}

class AddAccountPage extends StatefulWidget {
  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  final picker = ImagePicker();
  File? _image; // Store the picked image file
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _selectedBank;
  String? _accountNumber;

  // Define a list of bank options
  List<String> _bankOptions = ['HNB', 'NTB', 'NDB', 'Commercial Bank'];

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF1F332C),
        title: Text('Add Account'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 100.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // Show a dialog to select camera or gallery
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Select Image Source'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.camera),
                                  title: Text('Camera'),
                                  onTap: () {
                                    _pickImage(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.photo),
                                  title: Text('Gallery'),
                                  onTap: () {
                                    _pickImage(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor:
                        isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF044D33),
                    radius: 60.0,
                    child: _image != null
                        ? ClipOval(
                            child: Image.file(
                              _image!,
                              width: 120.0,
                              height: 120.0,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(
                            Icons.add_a_photo,
                            size: 70.0,
                          ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle form submission
                    _pickImage(ImageSource.gallery);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      isDarkMode
                          ? Color(0xFF2E4F4F)
                          : Color(
                              0xFF044D33), // Change this color to the desired color
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 12.0), // Adjust padding as needed
                    ),
                  ),
                  child: Text(
                    'Change Profile Image',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCBE4DE),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0), // Add horizontal padding
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _name = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0), // Add horizontal padding
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(labelText: 'Bank'),
                          value: _selectedBank,
                          items: _bankOptions.map((bank) {
                            return DropdownMenuItem<String>(
                              value: bank,
                              child: Text(bank),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedBank = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0), // Add horizontal padding
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Account Number'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the account number';
                            }
                            // You can add validation logic here
                            return null;
                          },
                          onSaved: (value) {
                            _accountNumber = value;
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          // Handle form submission
                          if (_formKey.currentState!.validate()) {
                            // Save form data
                            _formKey.currentState!.save();
                            // You can now use _name, _selectedBank, and _accountNumber
                            // to save the account information.
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            isDarkMode
                                ? Color(0xFF0E8388)
                                : Color(
                                    0xFF044D33), // Change this color to the desired color
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 12.0), // Adjust padding as needed
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
