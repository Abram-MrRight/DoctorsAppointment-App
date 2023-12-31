
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
}