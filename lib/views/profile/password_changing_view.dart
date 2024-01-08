import 'package:firebase_auth/firebase_auth.dart';
import 'package:doctors_appt/consts/colors.dart';
import 'package:doctors_appt/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PasswordChangeView extends StatefulWidget {
  const PasswordChangeView({Key? key}) : super(key: key);

  @override
  _PasswordChangeViewState createState() => _PasswordChangeViewState();
}

class _PasswordChangeViewState extends State<PasswordChangeView> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
  TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 4) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  Future<void> changePassword() async {
    try {
      final User? user = _auth.currentUser;

      if (user != null) {
        // Reauthenticate the user
        final AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPasswordController.text,
        );

        await user.reauthenticateWithCredential(credential);

        // Validate the new password
        final newPassword = newPasswordController.text;
        final confirmPassword = confirmNewPasswordController.text;

        final newPasswordError = validatePassword(newPassword);
        final confirmPasswordError =
        newPassword != confirmPassword ? 'Passwords do not match' : null;

        if (newPasswordError != null || confirmPasswordError != null) {
          VxToast.show(
            context,
            msg: newPasswordError ?? confirmPasswordError!,
            bgColor: Colors.red,
          );
          return;
        }

        // Change the user's password
        await user.updatePassword(newPassword);

        // Show success message
        VxToast.show(
            context,
            msg: "Password changed successfully",
            bgColor: Colors.red,
            textColor: Colors.white,
            position: VxToastPosition.top,
        );
        Navigator.of(context).pop();
      } else {
        // Handle the case where the user is not signed in
        VxToast.show(context, msg: "User not signed in");
      }
    } catch (e) {
      // Handle errors (e.g., invalid current password, weak password)
      VxToast.show(context, msg: "Error changing password: $e");
    }
  }

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
              decoration: InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            if (validatePassword(newPasswordController.text) != null)
              const SizedBox(height: 8.0),
            if (validatePassword(newPasswordController.text) != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  validatePassword(newPasswordController.text)!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 16.0),
            TextField(
              controller: confirmNewPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
            ),
            if (newPasswordController.text != confirmNewPasswordController.text)
              const SizedBox(height: 8.0),
            if (newPasswordController.text != confirmNewPasswordController.text)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Passwords do not match',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: changePassword,
              style: ElevatedButton.styleFrom(
                primary: AppColors.blueTheme,
                onPrimary: AppColors.whiteColor,
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
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
