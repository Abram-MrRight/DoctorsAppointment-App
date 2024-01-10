
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../consts/consts.dart';

class MyAppointmentController extends GetxController{
  var isLoading = false.obs;


  var appointmentDayController = TextEditingController();
  var appointmentTimeController = TextEditingController();
  var appointmentMobileController = TextEditingController();
  var appointmentNameController = TextEditingController();
  var appointmentMessageController = TextEditingController();

  bookAppointment(BuildContext context, String docId) async{
    isLoading (true);

    var store = FirebaseFirestore.instance.collection('appoimtments').doc();

    await store.set({
      'appBy' : FirebaseAuth.instance.currentUser?.uid,
      'appDay': appointmentDayController.text,
      'appTime': appointmentTimeController.text,
      'appMobile': appointmentMobileController.text,
      'appName': appointmentNameController.text,
      'appMessage': appointmentMessageController.text,
      'appWith' : docId,
    });

    isLoading(false);
    Get.snackbar(
      "Success",
      "Appointment is booked successfully!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green, // Customize the background color
      colorText: Colors.white, // Customize the text color
    );

  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAppointments(){
    return FirebaseFirestore.instance.collection('appoimtments').get();

  }

  Future<QuerySnapshot<Object?>> getCancelledAppointments() async {
    try {
      // Fetch cancelled appointments from Firestore
      QuerySnapshot<Object?> querySnapshot = await FirebaseFirestore.instance.collection('deletedAppointments').get();

      // Return the query snapshot
      return querySnapshot;
    } catch (e) {
      // Handle errors, e.g., show an error message
      print("Error fetching cancelled appointments: $e");
      throw e; // You might want to throw an exception or handle the error accordingly
    }
  }


}