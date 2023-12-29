
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appt/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class AppointmentController extends GetxController{
  var isLoading = false.obs;

  var appDayController = TextEditingController();
  var appTimeController = TextEditingController();
  var appMobileController = TextEditingController();
  var appNameController = TextEditingController();
  var appMessageController = TextEditingController();
  var docName = ''.obs;


  bookAppointment(String docID, BuildContext context) async{
    isLoading(true);

    var store = FirebaseFirestore.instance.collection('appointment').doc();
    await store.set({

      'appBy' : FirebaseAuth.instance.currentUser?.uid,
      'appDay' : appDayController.text,
      'appTime' : appTimeController.text,
      'appNumber' : appMobileController.text,
      'appName' :appNameController.text,
      'appMessage' : appMessageController.text,
      'appWith' : docID,
      'appWithName': docName
    });
    isLoading(false);
    VxToast.show(context, msg: "Appointment is booked successfully");
    Get.back();
  }
  Future<QuerySnapshot<Map<String, dynamic>>> getAppointments(){
    return FirebaseFirestore.instance.collection('appointment').get();

  }

}