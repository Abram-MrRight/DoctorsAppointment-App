import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appt/consts/consts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class  HomeController extends GetxController{
  var searchQueryController = TextEditingController();
  var isLoading = false.obs;


  Future<QuerySnapshot<Map<String, dynamic>>> getDoctorList() async{
    var doctors = await FirebaseFirestore.instance.collection('doctors').get();
    return doctors;

  }
}