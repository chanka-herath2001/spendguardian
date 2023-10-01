import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendguardian/theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: AddTransactionPage(),
    ),
  );
}

class AddTransactionPage extends StatefulWidget {
  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  String selectedType = 'Income'; // Default selected type

  DateTime selectedDate = DateTime.now();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController =
      TextEditingController(); // Default selected date

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    // Define text styles for Income and Expense buttons
    final incomeTextStyle = TextStyle(
      color: selectedType == 'Income'
          ? isDarkMode
              ? Color(0xFF2E4F4F)
              : Color(0xFF1F332C)
          : isDarkMode
              ? Color(0xFF0E8388)
              : Color(0xFF75EEAA),
      fontWeight: FontWeight.bold,
    );
    final expenseTextStyle = TextStyle(
      color: selectedType == 'Expense'
          ? isDarkMode
              ? Colors.white
              : Color(0xFF1F332C)
          : isDarkMode
              ? Color(0xFF0E8388)
              : Color(0xFF75EEAA),
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF1F332C),
        title: Text('Add Transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Toggle Buttons (Income/Expense)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedType = 'Income';
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        selectedType == 'Income'
                            ? isDarkMode
                                ? Color(0xFFCBE4DE)
                                : Color(0xFF75EEAA)
                            : isDarkMode
                                ? Color(0xFF2E4F4F)
                                : Color(0xFF1F332C),
                      ),
                    ),
                    child: Text(
                      'Income',
                      style: incomeTextStyle,
                    ),
                  ),
                  SizedBox(width: 16.0), // Add a small gap between the buttons
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedType = 'Expense';
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        selectedType == 'Expense'
                            ? isDarkMode
                                ? Color(0xFFE63E6D)
                                : Colors.red
                            : isDarkMode
                                ? Color(0xFF2E4F4F)
                                : Color(0xFF1F332C),
                      ),
                    ),
                    child: Text(
                      'Expense',
                      style: expenseTextStyle,
                    ),
                  ),
                ],
              ),

              // Date Picker
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

              // Amount Input
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

              // Category Input (You can use a DropdownButtonFormField or TextField)
              ListTile(
                title: Text('Category'),
                subtitle: TextFormField(
                  controller: categoryController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // Note Input (Multiline)
              ListTile(
                title: Text('Note (Optional)'),
                subtitle: TextFormField(
                  controller: noteController,
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // Description Input (Multiline)
              ListTile(
                title: Text('Description (Optional)'),
                subtitle: TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // Save Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle form submission
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      isDarkMode
                          ? Color(0xFF0E8388)
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
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Color(0xFFCBE4DE) : Color(0xFF75EEAA),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
