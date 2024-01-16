import '../pages/sidebar.dart';
import 'package:flutter/material.dart';

import '../components/widgets.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: text('Notifications'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage(
                  noImage
              ),
              radius: 16,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
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
            color: blueTheme
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
      IconData icon, String title, String message, String time) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: blueTheme),
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
