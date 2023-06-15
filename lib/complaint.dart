import 'package:flutter/material.dart';

class ComplaintCard extends StatelessWidget {
  final String complaintNumber;
  final String dateTime;
  final String complaintStatus;

  const ComplaintCard({super.key,
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
                'Date and Time:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(dateTime),
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

class Complaint extends StatelessWidget {
  const Complaint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Complaint',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: const Center(
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
              MaterialPageRoute(builder: (context) => const SubmitComplaint()),
            );
          },
          backgroundColor: Colors.orange,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class SubmitComplaint extends StatelessWidget {
  const SubmitComplaint({super.key});

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
