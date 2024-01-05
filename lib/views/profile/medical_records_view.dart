import 'package:doctors_appt/consts/colors.dart';
import 'package:flutter/material.dart';

class MedicalRecordsView extends StatelessWidget {
  const MedicalRecordsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      appBar: AppBar(
        title: const Text('Medical Records', style: TextStyle(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Records'),
            _buildRecordCard('Lab Test Results', Icons.document_scanner_outlined),
            _buildRecordCard('Imaging Reports', Icons.scanner),
            _buildRecordCard('Vital Signs History', Icons.monitor_heart_outlined),
            _buildRecordCard('Allergy Information', Icons.sentiment_very_dissatisfied_outlined),
            _buildRecordCard('Immunization History', Icons.local_hospital),
            _buildRecordCard('Surgeries & Other Procedures', Icons.cut),
            _buildRecordCard('Family Medical History', Icons.family_restroom),
            _buildRecordCard('Medication History', Icons.medication),
            _buildRecordCard('Hospitalization History', Icons.local_hospital),
            _buildRecordCard('Diet & Exercise Plans', Icons.fastfood),
            _buildRecordCard('Mental Health Records', Icons.headphones),
            _buildRecordCard('Dental Records', Icons.sentiment_very_satisfied),
            _buildRecordCard('Rehab & PT Records', Icons.run_circle),
            _buildRecordCard('Insurance Information', Icons.attach_money),
            _buildRecordCard('Emergency Contacts', Icons.contact_emergency_outlined),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
            color: AppColors.blueTheme
        ),
      ),
    );
  }

  Widget _buildRecordCard(String title, IconData icon) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(icon),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text( // file name or path
                      title,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () {
                    // logic for download
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.upload),
                  onPressed: () {
                    // logic for upload
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    // functionality for share
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}