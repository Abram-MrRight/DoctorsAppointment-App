import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class SettingsController extends GetxController{
  @override
  void onInit() {
    getData = getUserData();
    super.onInit();
  }

  var isLoading = false.obs;
  var currentUser = FirebaseAuth.instance.currentUser;
  var username = ''.obs;
  var email = ''.obs;
  Future? getData;

  getUserData() async{
    isLoading(true);
    DocumentSnapshot<Map<String, dynamic>> user =
    await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).get();
    var userData = user.data();
    username.value =userData!['fullname'] ?? "";
    email.value = currentUser!.email ?? '';
    isLoading(false);
  }
}