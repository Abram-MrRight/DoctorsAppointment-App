import 'package:doctors_appt/consts/colors.dart';
import 'package:doctors_appt/consts/consts.dart';
import 'package:flutter/material.dart';

class PasswordChangeView extends StatefulWidget {
  const PasswordChangeView({super.key});

  @override
  _PasswordChangeViewState createState() => _PasswordChangeViewState();
}

class _PasswordChangeViewState extends State<PasswordChangeView> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password', style: TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Current Password'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'New Password'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: confirmNewPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm New Password'),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Validate passwords and perform the update
                VxToast.show(context, msg: "Password changed");
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueTheme,
                foregroundColor: AppColors.whiteColor
              ),
              child: const Text('Update Password'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Implement forgot password logic here
              },
              child: Text(
                'Forgot password?',
                style: TextStyle(
                    color: AppColors.blueTheme,
                    fontWeight: FontWeight.w900
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
