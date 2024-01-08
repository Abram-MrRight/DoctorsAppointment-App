import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AppointmentEditDialog extends StatefulWidget {
  final String documentId;

  const AppointmentEditDialog({Key? key, required this.documentId}) : super(key: key);

  @override
  _AppointmentEditDialogState createState() => _AppointmentEditDialogState();
}

class _AppointmentEditDialogState extends State<AppointmentEditDialog> {
  final TextEditingController appointmentDayController = TextEditingController();
  final TextEditingController appointmentTimeController = TextEditingController();
  final TextEditingController appointmentMobileController = TextEditingController();
  final TextEditingController appointmentNameController = TextEditingController();
  final TextEditingController appointmentMessageController = TextEditingController();

  final CollectionReference appBy = FirebaseFirestore.instance.collection('appoimtments');

  @override
  void initState() {
    super.initState();
    populateControllers(widget.documentId);
  }

  void populateControllers(String documentId) async {
    // Fetch document data using documentId and populate controllers
    DocumentSnapshot docSnapshot = await appBy.doc(documentId).get();

    appointmentNameController.text = docSnapshot['appName'];
    appointmentMobileController.text = docSnapshot['appMobile'];
    appointmentDayController.text = docSnapshot['appDay'];
    appointmentTimeController.text = docSnapshot['appTime'];
    appointmentMessageController.text = docSnapshot['appMessage'];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 400,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: appointmentDayController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: appointmentTimeController,
              decoration: InputDecoration(labelText: 'Time'),
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: appointmentNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: appointmentMobileController,
              decoration: InputDecoration(labelText: 'Mobile'),
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: appointmentMessageController,
              decoration: InputDecoration(labelText: 'Message'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            update();
            Navigator.of(context).pop(); // Close dialog after update
          },
          child: Text("Update"),
        )
      ],
    );
  }

  Future<void> update() async {
    try {
      print("Updating document with ID: ${widget.documentId}");
      await appBy.doc(widget.documentId).update({
        'appName': appointmentNameController.text,
        'appMobile': appointmentMobileController.text,
        'appTime': appointmentTimeController.text,
        'appDay': appointmentDayController.text,
        'appMessage': appointmentMessageController.text,
      });

      // Optionally, show a success dialog
      showCustomDialog(
        title: "Success",
        message: "Appointment updated successfully",
        backgroundColor: Colors.green,
      );
      // Return to the previous screen (AppointmentView)
      Get.back();


      clearControllers();
      Get.back();
    } catch (e) {

      showCustomToast(
        message: "Error updating document: $e",
        backgroundColor: Colors.red,
      );
    }
  }

  void clearControllers() {
    appointmentMessageController.clear();
    appointmentMobileController.clear();
    appointmentNameController.clear();
    appointmentDayController.clear();
    appointmentTimeController.clear();
  }

  // Function to show a custom toast message
  void showCustomToast({
    required String message,
    required Color backgroundColor,
  }) {
    if (mounted) {
      final scaffoldContext = ScaffoldMessenger.of(context).context;

      // Ensure that the context is not null
      if (scaffoldContext != null) {
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: backgroundColor,
          textColor: Colors.white,
        );
      }
    }
  }

  static void showCustomDialog({
    required String title,
    required String message,
    required Color backgroundColor,
  }) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      backgroundColor: backgroundColor,
      titleStyle: TextStyle(color: Colors.white),
      middleTextStyle: TextStyle(color: Colors.white),
    );
  }
}
