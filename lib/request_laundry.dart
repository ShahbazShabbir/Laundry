import 'package:flutter/material.dart';

class Request extends StatelessWidget {
  const Request({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Laundry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Uniform',
                hintText: 'Enter Number of Uniform for Laundry',
                prefixIcon: const Icon(Icons.person_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Perform button action
                print('Button pressed');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.orange,
                textStyle: const TextStyle(fontSize: 18.0),
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                elevation: 2.0,
                shadowColor: Colors.black,
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String dateTime;
  final int numberOfItems;
  final String orderStatus;

  const OrderCard({super.key,
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
      elevation: 6.0,
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),

    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    ListTile(
    title: const Text(
    'Order Number:',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    ),
    ),
    subtitle: Text(orderNumber),
    ),

    ListTile(
    title: const Text(
    'Date and Time:',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    ),
    ),
    subtitle: Text(dateTime),
    ),

    ListTile(
    title: const Text(
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
  const RequestLaundry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laundry Request List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
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
//       debugShowCheckedModeBanner: false,
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
