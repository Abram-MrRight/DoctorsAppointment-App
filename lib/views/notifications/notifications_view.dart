import 'package:doctors_appt/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/fonts.dart';
import '../../consts/images.dart';
import '../profile/profile_view.dart';
import '../search_view/search_entry_view.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: AppStyles.bold(
          title: "Notifications",
          size: AppSizes.size18.toDouble(),
          color: AppColors.whiteColor,
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
      body: ListView(
        children: [
          _buildNotificationHeader('Today'),
          _buildNotificationItem(
            Icons.notifications,
            'Appointment Reminder',
            'Don\'t forget your doctor appointment at 2:00 PM.',
            '10:00 AM',
          ),
          _buildNotificationItem(
            Icons.notifications,
            'New Message',
            'You have a new message from Dr. Smith.',
            '9:30 AM',
          ),
          _buildNotificationItem(
            Icons.notifications,
            'Patient Review: Ms. Joanna',
            'Awesome patient care!',
            '8:44 AM',
          ),
          _buildNotificationHeader('Yesterday'),
          _buildNotificationItem(
            Icons.notifications,
            'Missed Call',
            'Dr. Johnson tried to reach you. Please call back.',
            '3:45 PM',
          ),

          _buildNotificationHeader('Last Week'),
          _buildNotificationItem(
            Icons.notifications,
            'Follow-up Reminder',
            'Follow up with Dr. Brown regarding your test results.',
            'Dec 28, 2023, 1:20 PM',
          ),
          // Add more notification items as needed
        ],
      ),
    );
  }

  Widget _buildNotificationHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,
          color: AppColors.blueTheme
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
      IconData icon, String title, String message, String time) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: AppColors.blueTheme),
        title: Text(title),
        subtitle: Text(message),
        trailing: Text(time),
        onTap: () {
          // Add functionality for tapping on a notification item
        },
      ),
    );
  }
}
