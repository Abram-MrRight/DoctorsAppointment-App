import 'package:doctors_appt/consts/colors.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Account'),
            _buildSettingCard('User Profile', Icons.account_circle),
            _buildSettingCard('Change Password', Icons.lock),
            _buildSettingCard('Deactivate Account', Icons.cancel),

            _buildSectionHeader('Display'),
            _buildSettingCard('Theme', Icons.color_lens),
            _buildSettingCard('Text Size', Icons.text_fields),

            _buildSectionHeader('Subscribe'),
            _buildSettingCard('Basic', Icons.star),
            _buildSettingCard('Premium', Icons.star_border),
            _buildSettingCard('Premium Plus', Icons.star_half),

            _buildSectionHeader('Monetization'),
            _buildSettingCard('Carousel Ads', Icons.slideshow),
            _buildSettingCard('Email Ads', Icons.email),

            _buildSectionHeader('Notifications'),
            _buildSettingCard('Filters', Icons.filter_list),
            _buildSettingCard('Preferences', Icons.settings),

            _buildSectionHeader('Accessibility'),
            _buildSettingCard('Screen Reader', Icons.screen_search_desktop_outlined),
            _buildSettingCard('Animations', Icons.animation),
            _buildSettingCard('Media', Icons.audiotrack),
            _buildSettingCard('Gestures', Icons.touch_app),
            _buildSettingCard('Preferred Language', Icons.language),
            _buildSettingCard('Data Usage', Icons.data_usage),

            _buildSectionHeader('Legal'),
            _buildSettingCard('Ads Info', Icons.info),
            _buildSettingCard('Privacy Policy', Icons.privacy_tip),
            _buildSettingCard('Terms of Service', Icons.assignment),
            _buildSettingCard('Legal Notices', Icons.gavel),

            _buildSectionHeader('About'),
            _buildSettingCard('App Info', Icons.info_outline),
            _buildSettingCard('Developers', Icons.developer_mode),
            _buildSettingCard('Help Center', Icons.help),
            _buildSettingCard('Marketing', Icons.mark_email_read),
            _buildSettingCard('Share the App', Icons.share),
            _buildSettingCard('App Version', Icons.info),
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

  Widget _buildSettingCard(String title, IconData icon) {
    return Card(
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
        onTap: () {
          // Add functionality for each setting here
        },
      ),
    );
  }
}