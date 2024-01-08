
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';

class DeleteAppointment {
  static Future<void> deleteAppointment(String documentId) async {
    try {
      await FirebaseFirestore.instance.collection('appoimtments').doc(documentId).delete();

      // Optionally, show a success dialog
      showCustomDialog(
          title: "Success",
          message: "Appointment deleted successfully",
          backgroundColor: Colors.green,
      );
      // Return to the previous screen (AppointmentView)
      Get.back();

      // You might want to update the UI or fetch updated data here
    } catch (e) {
      // Show an error dialog
      showCustomDialog(
        title: "Error",
        message: "Error deleting appointment: $e",
        backgroundColor: Colors.red,
      );
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