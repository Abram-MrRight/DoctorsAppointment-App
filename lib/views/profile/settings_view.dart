import 'package:doctors_appt/consts/colors.dart';
import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/views/profile/password_changing_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
            _buildSettingCard(title:  'User Profile', icon:  Icons.account_circle),

            _buildSettingCard(
               title:  'Change Password',
               icon:  Icons.lock,
              callback: () {
                Get.to(() => PasswordChangeView());
              },
            ),
            _buildSettingCard(title: 'Deactivate Account',icon:  Icons.cancel),

            _buildSectionHeader('Display'),
            _buildSettingCard( title: 'Theme', icon: Icons.color_lens),
            _buildSettingCard(title: 'Text Size',icon:  Icons.text_fields),

            _buildSectionHeader('Subscribe'),
            _buildSettingCard(title: 'Basic',icon:  Icons.star),
            _buildSettingCard(title:  'Premium',icon:  Icons.star_border),
            _buildSettingCard(title: 'Premium Plus', icon: Icons.star_half),

            _buildSectionHeader('Monetization'),
            _buildSettingCard(title:  'Carousel Ads',icon:  Icons.slideshow),
            _buildSettingCard(title:  'Email Ads',icon:  Icons.email),

            _buildSectionHeader('Notifications'),
            _buildSettingCard(title: 'Filters', icon:  Icons.filter_list),
            _buildSettingCard(title:  'Preferences',icon:  Icons.settings),

            _buildSectionHeader('Accessibility'),
            _buildSettingCard(title:  'Screen Reader',icon:  Icons.screen_search_desktop_outlined),
            _buildSettingCard(title: 'Animations', icon: Icons.animation),
            _buildSettingCard(title: 'Media', icon: Icons.audiotrack),
            _buildSettingCard(title: 'Gestures',icon:  Icons.touch_app),
            _buildSettingCard(title: 'Preferred Language',icon:  Icons.language),
            _buildSettingCard(title: 'Data Usage', icon: Icons.data_usage),

            _buildSectionHeader('Legal'),
            _buildSettingCard(title: 'Ads Info',icon:  Icons.info),
            _buildSettingCard(title: 'Privacy Policy',icon:  Icons.privacy_tip),
            _buildSettingCard(title: 'Terms of Service', icon: Icons.assignment),
            _buildSettingCard(title: 'Legal Notices',icon:  Icons.gavel),

            _buildSectionHeader('About'),
            _buildSettingCard(title: 'App Info',icon:  Icons.info_outline),
            _buildSettingCard(title: 'Developers',icon:  Icons.developer_mode),
            _buildSettingCard(title: 'Help Center', icon: Icons.help),
            _buildSettingCard( title: 'Marketing', icon: Icons.mark_email_read),
            _buildSettingCard(title: 'Share the App',icon:  Icons.share),
            _buildSettingCard(title: 'App Version',icon:  Icons.info),
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

  Widget _buildSettingCard({required String title, required IconData icon, Function? callback}) {
    return Card(
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
        onTap: ()  {
          // Add functionality for each setting here
          callback?.call();
        },
      ),
    );
  }
}