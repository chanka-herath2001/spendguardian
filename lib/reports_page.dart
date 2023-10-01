import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'theme_notifier.dart';
import 'transaction_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: ReportsPage(),
    ),
  );
}

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  int _currentIndex = 2; // Initially, set the second tab as active
  bool _showIncome = true;
  bool _showMonthlyIncome =
      true; // Initially, show income data on the pie chart

  // Function to handle bottom navigation item tap
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the selected index when a tab is tapped
    });

    // Handle navigation based on the selected tab here
    switch (index) {
      case 0:
        // Handle Home tab
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        break;
      case 1:
        // Handle Transactions tab (current page)
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => TransactionsPage(),
          ),
        );
        break;
      case 2:
        // Handle Reports tab
        // Do nothing, already on the Reports page
        break;
      case 3:
        // Handle Profile tab
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF1F332C),
        title: Text('Reports'),
        titleSpacing: 105.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color(0xFF1F332C),
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(16.0), // Adjust the radius as needed
                  bottomRight:
                      Radius.circular(16.0), // Adjust the radius as needed
                ),
              ), // Set the background color here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showIncome = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                              _showIncome ? Color(0xFF0E8388) : Colors.white,
                        ),
                        child: Text(
                          'Income',
                          style: TextStyle(
                            color:
                                _showIncome ? Colors.white : Color(0xFF0E8388),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showIncome = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                              !_showIncome ? Color(0xFF950101) : Colors.white,
                        ),
                        child: Text(
                          'Expenses',
                          style: TextStyle(
                            color:
                                !_showIncome ? Colors.white : Color(0xFF0E8388),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: 250,
                    height: 250,
                    child: PieChart(
                      PieChartData(
                        sections: _showIncome ? incomeData() : expensesData(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0), // Add margin between sections
            Container(
              // Container for the monthly report section
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0), // Add margin
              child: Column(
                children: <Widget>[
                  Text(
                    'Monthly Report',
                    style: TextStyle(
                      fontSize: 20.0, // Set the desired font size
                      fontWeight: FontWeight.bold, // Apply bold font weight
                      color: isDarkMode
                          ? Color(0xFF0E8388)
                          : Color(0xFF0A875A), // Set the text color
                    ),
                  ),
                  SizedBox(
                      height: 10.0), // Add spacing between title and buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showMonthlyIncome = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: _showMonthlyIncome
                              ? Color(0xFF0E8388)
                              : Colors.white,
                        ),
                        child: Text(
                          'Income',
                          style: TextStyle(
                            color: _showMonthlyIncome
                                ? Colors.white
                                : Color(0xFF0E8388),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showMonthlyIncome = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: !_showMonthlyIncome
                              ? Color(0xFF950101)
                              : Colors.white,
                        ),
                        child: Text(
                          'Expense',
                          style: TextStyle(
                            color: !_showMonthlyIncome
                                ? Colors.white
                                : Color(0xFF0E8388),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: 400,
                    height: 300,
                    child: _showMonthlyIncome
                        ? incomeBarChart()
                        : expenseBarChart(),
                  ),
                ],
              ),
            ),
          ],
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
          selectedItemColor: isDarkMode ? Color(0xFFCBE4DE) : Color(0xFF0E8388),
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
  }

  List<PieChartSectionData> incomeData() {
    // Replace with your income data
    return [
      PieChartSectionData(
        value: 30,
        title: 'Salary',
        color: Color(0xFF0E8388),
        titleStyle: TextStyle(
            fontSize: 16, // Adjust the font size
            color: Colors.white,
            fontWeight: FontWeight.bold // Adjust the text color
            ),
      ),
      PieChartSectionData(
        value: 20,
        title: 'Investments',
        color: Colors.green,
        titleStyle: TextStyle(
            fontSize: 16, // Adjust the font size
            color: Colors.white,
            fontWeight: FontWeight.bold // Adjust the text color
            ),
      ),
      PieChartSectionData(
        value: 10,
        title: 'Gifts',
        color: const Color(0xFF044D33),
        titleStyle: TextStyle(
            fontSize: 16, // Adjust the font size
            color: Colors.white,
            fontWeight: FontWeight.bold // Adjust the text color
            ),
      ),
      // Add more income data sections as needed
    ];
  }

  List<PieChartSectionData> expensesData() {
    // Replace with your expenses data
    return [
      PieChartSectionData(
        value: 40,
        title: 'Groceries',
        color: const Color(0xFF0E8388),
        titleStyle: TextStyle(
            fontSize: 16, // Adjust the font size
            color: Colors.white,
            fontWeight: FontWeight.bold // Adjust the text color
            ),
      ),
      PieChartSectionData(
        value: 30,
        title: 'Utilities',
        color: const Color(0xFF75EEAA),
        titleStyle: TextStyle(
            fontSize: 16, // Adjust the font size
            color: Colors.white,
            fontWeight: FontWeight.bold // Adjust the text color
            ),
      ),
      PieChartSectionData(
        value: 20,
        title: 'Transportation',
        color: const Color(0xFF044D33),
        titleStyle: TextStyle(
            fontSize: 16, // Adjust the font size
            color: Colors.white,
            fontWeight: FontWeight.bold // Adjust the text color
            ),
      ),
      PieChartSectionData(
        value: 10,
        title: 'Entertainment',
        color: Colors.green,
        titleStyle: TextStyle(
            fontSize: 16, // Adjust the font size
            color: Colors.white,
            fontWeight: FontWeight.bold // Adjust the text color
            ),
      ),
      // Add more expenses data sections as needed
    ];
  }

  Widget incomeBarChart() {
    final isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    return Container(
      height: 600,
      child: AspectRatio(
        aspectRatio: 2.0, // Set the desired height for the bar chart
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 1200, // Adjust the maximum Y value as needed
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    y: 800, // Replace with your monthly income data for January
                    colors: [
                      isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF0E8388)
                    ], // Color of the bar
                  ),
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    y: 900, // Replace with your monthly income data for February
                    colors: [
                      isDarkMode ? Color(0xFFCBE4DE) : Color(0xFF044D33)
                    ], // Color of the bar
                  ),
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                    y: 750, // Replace with your monthly income data for March
                    colors: [
                      isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF0E8388)
                    ], // Color of the bar
                  ),
                ],
              ),
              // Add more BarChartGroupData for each month
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                    y: 550, // Replace with your monthly income data for March
                    colors: [
                      isDarkMode ? Color(0xFFCBE4DE) : Color(0xFF044D33)
                    ], // Color of the bar
                  ),
                ],
              ),
              BarChartGroupData(
                x: 4,
                barRods: [
                  BarChartRodData(
                    y: 900, // Replace with your monthly income data for March
                    colors: [
                      isDarkMode ? Color(0xFF2E4F4F) : Color(0xFF0E8388)
                    ], // Color of the bar
                  ),
                ],
              ),
              BarChartGroupData(
                x: 5,
                barRods: [
                  BarChartRodData(
                    y: 250, // Replace with your monthly income data for March
                    colors: [
                      isDarkMode ? Color(0xFFCBE4DE) : Color(0xFF044D33)
                    ], // Color of the bar
                  ),
                ],
              ),
            ],
            titlesData: FlTitlesData(
              leftTitles: SideTitles(showTitles: true),
              rightTitles: SideTitles(showTitles: false),
              topTitles: SideTitles(showTitles: false),
              bottomTitles: SideTitles(
                showTitles: true,
                getTitles: (double value) {
                  // Replace with your month labels (e.g., Jan, Feb, Mar, etc.)
                  switch (value.toInt()) {
                    case 0:
                      return 'Jan';
                    case 1:
                      return 'Feb';
                    case 2:
                      return 'Mar';
                    case 3:
                      return 'Apr';
                    case 4:
                      return 'May';
                    case 5:
                      return 'Jun';
                    case 6:
                      return 'Jul';
                    default:
                      return '';
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget expenseBarChart() {
    final isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    return Container(
      height: 600,
      child: AspectRatio(
        aspectRatio: 2.0, // Set the desired height for the bar chart
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 1200, // Adjust the maximum Y value as needed
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    y: 600, // Replace with your monthly income data for January
                    colors: [
                      isDarkMode ? Color(0xFFE63E6D) : Colors.red
                    ], // Color of the bar
                  ),
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    y: 700, // Replace with your monthly income data for February
                    colors: [
                      isDarkMode ? Color(0xFF7D1935) : Color(0xFF950101)
                    ], // Color of the bar
                  ),
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                    y: 900, // Replace with your monthly income data for March
                    colors: [
                      isDarkMode ? Color(0xFFE63E6D) : Colors.red
                    ], // Color of the bar
                  ),
                ],
              ),
              // Add more BarChartGroupData for each month
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                    y: 750, // Replace with your monthly income data for March
                    colors: [
                      isDarkMode ? Color(0xFF7D1935) : Color(0xFF950101)
                    ], // Color of the bar
                  ),
                ],
              ),
              BarChartGroupData(
                x: 4,
                barRods: [
                  BarChartRodData(
                    y: 300, // Replace with your monthly income data for March
                    colors: [
                      isDarkMode ? Color(0xFFE63E6D) : Colors.red
                    ], // Color of the bar
                  ),
                ],
              ),
              BarChartGroupData(
                x: 5,
                barRods: [
                  BarChartRodData(
                    y: 850, // Replace with your monthly income data for March
                    colors: [
                      isDarkMode ? Color(0xFF7D1935) : Color(0xFF950101)
                    ], // Color of the bar
                  ),
                ],
              ),
            ],
            titlesData: FlTitlesData(
              leftTitles: SideTitles(showTitles: true),
              rightTitles: SideTitles(showTitles: false),
              topTitles: SideTitles(showTitles: false),
              bottomTitles: SideTitles(
                showTitles: true,
                getTitles: (double value) {
                  // Replace with your month labels (e.g., Jan, Feb, Mar, etc.)
                  switch (value.toInt()) {
                    case 0:
                      return 'Jan';
                    case 1:
                      return 'Feb';
                    case 2:
                      return 'Mar';
                    case 3:
                      return 'Apr';
                    case 4:
                      return 'May';
                    case 5:
                      return 'Jun';
                    case 6:
                      return 'Jul';
                    default:
                      return '';
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
