import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: EditProfilePage(),
    ),
  );
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final picker = ImagePicker();
  File? _image;
  final _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _lastName;
  String? _email;

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
        title: Text('Edit Profile'),
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
                    _pickImage(ImageSource.gallery);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF044D33),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
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
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'First Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _firstName = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Last Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _lastName = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Email Address'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _email = value;
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
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            isDarkMode ? Color(0xFF0E8388) : Color(0xFF044D33),
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 12.0),
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
