import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:one/shared_preferences.dart';

class ComplaintCard extends StatelessWidget {
  final String complaintNumber;
  final String complaintStatus;

  const ComplaintCard({
    required this.complaintNumber,
    required this.complaintStatus,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (complaintStatus) {
      case 'Accepted':
        statusColor = Colors.green;
        break;
      case 'Declined':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.orange;
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
              title: const Text(
                'Complaint Number:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(complaintNumber),
            ),
            ListTile(
              title: const Text(
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

class Complaint extends StatefulWidget {
  const Complaint({Key? key}) : super(key: key);

  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  List<ComplaintCard> complaintCards = [];

  @override
  void initState() {
    super.initState();
    fetchComplaintData();
  }

  Future<void> fetchComplaintData() async {
    final url = 'https://jetex.jirlie.com/api/resource/Complain?fields=["name","workflow_state"]';

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

        List<ComplaintCard> cards = [];

        for (var complaint in data["data"]) {
          final complaintNumber = complaint['name'];
          final complaintStatus = complaint['workflow_state'];

          cards.add(
            ComplaintCard(
              complaintNumber: complaintNumber,
              complaintStatus: complaintStatus,
            ),
          );
        }

        setState(() {
          complaintCards = cards;
        });
      } else {
        print('Failed to fetch complaint cards. Error: ${response.statusCode}');
      }
    } else {
      print('API credentials not available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint'),
      ),
      body: ListView.builder(
        itemCount: complaintCards.length,
        itemBuilder: (context, index) => complaintCards[index],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open new window
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SubmitComplaint()),
          );
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SubmitComplaint extends StatelessWidget {
  const SubmitComplaint({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint'),
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
                labelText: 'Complaint',
                hintText: 'Enter your complaint',
                prefixIcon: const Icon(Icons.lock),
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
