import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/controllers/settings_controller.dart';
import 'package:doctors_appt/views/home_view/home_view.dart';
import 'package:doctors_appt/views/profile/profile_view.dart';
import 'package:doctors_appt/views/search_view/search_entry_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var userController = Get.put(SettingsController());

    return Scaffold(
      drawer: const ProfileView(),
      appBar: AppBar(
        elevation: 0.0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage(
                  Appassets.imgDefault
              ),
              radius: 16,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyles.bold(
              title: "Hello ${userController.username.value}",
              size: AppSizes.size18.toDouble(),
              color: AppColors.whiteColor,
            ),
            const Text(
              "How are you today?",
              style: TextStyle(
                  fontSize: 12
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
                Icons.search
            ),
            onPressed: () {
              Get.to(() => const SearchEntryView());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionHeader('Upcoming Appointments'),
              _buildAppointmentCard('John Doe', 'January 15, 2024 - 2:00 PM'),
              _buildAppointmentCard('Jane Smith', 'January 18, 2024 - 3:30 PM'),

              16.heightBox,

              const HorizontalAdvertCardList(),

              _buildSectionHeader('Patient Records'),
              _buildPatientRecordCard('Patient A'),
              _buildPatientRecordCard('Patient B'),

              _buildSectionHeader('News Feed'),
              _buildNewsFeedCard('Latest Medical Breakthroughs'),
              _buildNewsFeedCard('Health Research Updates'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'View All',
              style: TextStyle(
                  color: AppColors.blueTheme
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(String patientName, String time) {
    return Card(
      child: ListTile(
        title: Text('Patient: $patientName'),
        subtitle: Text('Time: $time'),
        onTap: () {
          // Add functionality for tapping on an appointment
        },
      ),
    );
  }

  Widget _buildPatientRecordCard(String patientName) {
    return Card(
      child: ListTile(
        title: Text('Patient: $patientName'),
        onTap: () {
          // Add functionality for tapping on a patient record
        },
      ),
    );
  }

  Widget _buildNewsFeedCard(String topic) {
    return Card(
      child: ListTile(
        title: Text('Topic: $topic'),
        subtitle: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
        onTap: () {
          // Add functionality for tapping on a news feed item
        },
      ),
    );
  }
}
