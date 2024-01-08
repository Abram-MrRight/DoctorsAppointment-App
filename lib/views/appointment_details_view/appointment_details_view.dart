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
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 5.0,
               borderRadius: BorderRadius.circular(12),
               child: Container(
                 width: 400,
                 padding: EdgeInsets.all(20),
                 decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       'Date: ${doc?['appDay']}',
                       style: const TextStyle(fontSize: 20.0, color: Colors.blue, fontWeight: FontWeight.bold),
                     ),
                     const SizedBox(height: 12.0),
                     Text(
                       'Time: ${doc!['appTime']}',
                       style: const TextStyle(fontSize: 18.0, color: Colors.orange, fontWeight: FontWeight.bold),
                     ),
                     const SizedBox(height: 12.0),
                     Text(
                       'Full Name: ${doc!['appName']}',
                       style: TextStyle(fontSize: 18.0,  color: Colors.blue, fontWeight: FontWeight.bold),
                     ),
                     const SizedBox(height: 12.0),
                     Text(
                       'Contact: ${doc!['appMobile']}',
                       style: TextStyle(fontSize: 18.0,  color: Colors.orange, fontWeight: FontWeight.bold),
                     ),
                     const SizedBox(height: 12.0),
                     Text(
                       'Details: ${doc!['appMessage']}',
                       style: const TextStyle(fontSize: 18.0,  color: Colors.blue, fontWeight: FontWeight.bold),
                     ),
                   ],
                 ),
               ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

