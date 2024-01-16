import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appt/beta/components/widgets.dart';
import 'package:doctors_appt/beta/models/appointments.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsPage extends StatelessWidget {
  AppointmentModel appointment;
  bool isDoctor;
  AppointmentDetailsPage({super.key, required this.appointment, required this.isDoctor});

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
                  child: futureAppointmentDetail(appointment, isDoctor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

