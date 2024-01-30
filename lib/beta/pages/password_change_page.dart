import '../constants/compound_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/widgets.dart';
import '../constants/colors.dart';

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({Key? key}) : super(key: key);

  @override
  _PasswordChangePageState createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

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
          password: inputControllers['currentPassword']!.text,
        );

        await user.reauthenticateWithCredential(credential);

        // Validate the new password
        final newPassword = inputControllers['password']!.text;
        final confirmPassword = inputControllers['confirmPassword']!.text;

        final newPasswordError = validatePassword(newPassword);
        final confirmPasswordError =
        newPassword != confirmPassword ? 'Passwords do not match' : null;

        if (newPasswordError != null || confirmPasswordError != null) {
          toast(newPasswordError ?? confirmPasswordError!, bgColor: danger);
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: inputControllers['currentPassword'],
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.isEmptyOrNull) {
                    return 'This field is required';
                  }
                  else if (value!.length < 6) {
                    return 'Password length must be at least 6 characters';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: inputControllers['password'],
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Password length must be at least 6 characters';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: inputControllers['confirmPassword'],
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (inputControllers['password']!.text != inputControllers['confirmPassword']!.text) {
                    return 'Passwords do not match';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    toast('Check the form fields and try again');
                  }
                  else {
                    changePassword();
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: light, backgroundColor: blueTheme,
                ),
                child: const Text('Update Password'),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  // request password reset token
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: blueTheme,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
