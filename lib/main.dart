import 'dart:async';

import 'package:flutter/material.dart';
import 'package:one/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laundry',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home:SplashApp(),
    );
  }
}

class SplashApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Text(
          'Logo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
                textStyle: TextStyle(fontSize: 18.0),
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                elevation: 2.0,
                shadowColor: Colors.black,

              ),
            ),
          ],
        ),
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laundry App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    HomePage(),
    RequestLaundry(),
    Complaint(),
    ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laundry App'),
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Request Laundry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'Complaint',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Page',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String dateTime;
  final int numberOfItems;
  final String orderStatus;

  const OrderCard({
    required this.orderNumber,
    required this.dateTime,
    required this.numberOfItems,
    required this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {

    Color statusColor;
    switch (orderStatus) {
      case 'In Progress':
        statusColor = Colors.orange;
        break;
      case 'Delivered':
        statusColor = Colors.green;
        break;
      case 'Cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.black;
        break;
    }

    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(0.0),

    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    ListTile(
    title: Text(
    'Order Number:',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    ),
    ),
    subtitle: Text(orderNumber),
    ),
    ListTile(
    title: Text(
    'Date and Time:',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    ),
    ),
    subtitle: Text(dateTime),
    ),
    ListTile(
    title: Text(
    'Number of Items:',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    ),
    ),
    subtitle: Text(numberOfItems.toString()),
    ),
    ListTile(
    title: Text(
    'Order Status:',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    ),
    ),
      subtitle: Text(
        orderStatus,
        style: TextStyle(
          color: statusColor,
        ),
      ),

    ),
    ],
    ),

      ),
    );
  }
}


class RequestLaundry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Card Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(

          child: Card(
            elevation: 50,
            shadowColor: Colors.black,
            child: Column(
              children: [
                OrderCard(
                  orderNumber: '1234',
                  dateTime: 'June 8, 2023, 10:00 AM',
                  numberOfItems: 5,
                  orderStatus: 'In Progress',
                ),
                OrderCard(
                  orderNumber: '6677',
                  dateTime: 'June 8, 2023, 10:00 AM',
                  numberOfItems: 5,
                  orderStatus: 'Delivered',
                ),
              ],
            ),
          ),

        ),
    ),
    );
  }
}



// class RequestLaundry extends StatelessWidget {
//   final List<Person> people = [
//     Person('Uniform 1', 'assets/images/person1.jpg'),
//     Person('Uniform 2', 'assets/images/person2.jpg'),
//     Person('Uniform 3', 'assets/images/person3.jpg'),
//     Person('Uniform 4', 'assets/images/person4.jpg'),
//     Person('Uniform 5', 'assets/images/person5.jpg'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'RequestLaundry',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         body: ListView.builder(
//           itemCount: people.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: AssetImage(people[index].imagePath),
//               ),
//               title: Text(people[index].name),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
//
// class Person {
//   final String name;
//   final String imagePath;
//
//   Person(this.name, this.imagePath);
// }
class ComplaintCard extends StatelessWidget {
  final String complaintNumber;
  final String dateTime;
  final String complaintStatus;

  const ComplaintCard({
    required this.complaintNumber,
    required this.dateTime,
    required this.complaintStatus,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (complaintStatus) {
      case 'In Progress':
        statusColor = Colors.orange;
        break;
      case 'Solved':
        statusColor = Colors.green;
        break;
      case 'Cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.black;
        break;
    }

    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Complaint Number:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(complaintNumber),
            ),
            ListTile(
              title: Text(
                'Date and Time:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(dateTime),
            ),
            ListTile(
              title: Text(
                'Complaint Status:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                complaintStatus,
                style: TextStyle(
                  color: statusColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Complaint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complaint',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Center(
          child: Card(
            elevation: 5,
            shadowColor: Colors.black,
            child: Column(
              children: [
                ComplaintCard(
                  complaintNumber: '1234',
                  dateTime: 'June 8, 2023, 10:00 AM',
                  complaintStatus: 'In Progress',
                ),
                ComplaintCard(
                  complaintNumber: '6677',
                  dateTime: 'June 8, 2023, 10:00 AM',
                  complaintStatus: 'Solved',
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Open new window
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SubmitComplaint()),
            );
          },
          backgroundColor: Colors.orange,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}



class SubmitComplaint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Complaint',
                hintText: 'Enter your complaint',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Perform button action
                print('Button pressed');
              },
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
                textStyle: TextStyle(fontSize: 18.0),
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                elevation: 2.0,
                shadowColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class ChatPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Chat Page',
//         style: TextStyle(fontSize: 24.0),
//       ),
//     );
//   }
// }


class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with your chat message count
              reverse: true, // To display the latest message at the bottom
              itemBuilder: (context, index) {
                return ChatBubble(
                  message: 'Hello, how are you?', // Replace with actual message
                  isMe: index % 2 == 0, // Alternate between sender and receiver
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Perform send message action
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor = isMe ? Colors.orange[200] : Colors.grey[200];
    final textColor = isMe ? Colors.black : Colors.black;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: align,
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            '12:34 PM', // Replace with actual timestamp
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
