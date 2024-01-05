import 'package:cloud_firestore/cloud_firestore.dart';
import '../../consts/consts.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsView extends StatelessWidget {
  final QueryDocumentSnapshot? doc;
  const AppointmentDetailsView({super.key,
    required this.doc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: ${doc?['appDay']}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 12.0),
            Text(
              'Time: ${doc!['appTime']}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 12.0),
            const Text(
              'Location: --',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 12.0),
            Text(
              'Details: ${doc!['appMessage']}',
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}

