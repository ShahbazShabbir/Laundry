import 'package:flutter/material.dart';
import 'package:one/damage.dart';
import 'package:one/request_laundry.dart';
import 'package:one/complaint.dart';
import 'package:one/chat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:one/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jetex',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    HomePage(),
    const RequestLaundry(),
    const Complaint(),
    const Damage(),
    const ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jetex'),
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_laundry_service),
            label: 'Laundry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: 'Complaint',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dangerous),
            label: 'Damage',
          ),

        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String totalUniformValue = '';
  String assignedUniformValue = '';
  String inLaundryValue = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = 'https://jetex.jirlie.com/api/resource/Uniform';

    final credentials = await AppPreferences.getApiCredentials();
    final apiKey = credentials['apiKey'];
    final apiSecret = credentials['apiSecret'];

    if (apiKey != null && apiSecret != null) {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'token $apiKey:$apiSecret'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        totalUniformValue = data["data"].length.toString();
        assignedUniformValue = "4 (Dummy)".toString();
        inLaundryValue = "2 (Dummy)".toString();

        setState(() {});
      } else {
        // Handle API error
        // You can show an error message or perform any necessary actions
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: const Text(
                  'Total Uniform',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  totalUniformValue,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      title: const Text(
                        'Assigned Uniform',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        assignedUniformValue,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      title: const Text(
                        'In Laundry',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        inLaundryValue,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(16.0),
        // Your bottom navigation bar content goes here
      ),
    );
  }
}

// Other classes remain unchanged
