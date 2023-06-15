import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:one/shared_preferences.dart';

class Request extends StatelessWidget {
  const Request({Key? key}) : super(key: key);

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
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange,
                textStyle: const TextStyle(fontSize: 18.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 16.0),
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
  final String orderStatus;

  const OrderCard({
    required this.orderNumber,
    required this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (orderStatus) {
      case 'Washed':
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

class RequestLaundry extends StatefulWidget {
  const RequestLaundry({Key? key});

  @override
  _RequestLaundryState createState() => _RequestLaundryState();
}

class _RequestLaundryState extends State<RequestLaundry> {
  Future<List<OrderCard>> fetchOrderCards() async {
    final url = 'https://jetex.jirlie.com/api/resource/Laundry%20Request?fields=["name","workflow_state"]';

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

        List<OrderCard> orderCards = [];

        for (var order in data["data"]) {
          final orderNumber = order['name'];
          final orderStatus = order['workflow_state'];

          orderCards.add(
            OrderCard(
              orderNumber: orderNumber,
              orderStatus: orderStatus,
            ),
          );
        }
        return orderCards;
      } else {
        throw Exception('Failed to fetch order cards');
      }
    } else {
      throw Exception('API credentials not available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laundry Request List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: FutureBuilder<List<OrderCard>>(
          future: fetchOrderCards(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Open new window
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Request()),
            );
          },
          backgroundColor: Colors.orange,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
