import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appt/views/home_view/home_view.dart';
import 'package:doctors_appt/views/login_view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../consts/consts.dart';


class AuthController extends GetxController{

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController= TextEditingController();
  final confirmPassword = TextEditingController();
  final contactController = TextEditingController();
  final locationController = TextEditingController();
  final allergiesController= TextEditingController();
  String bloodGroupController = '';
  String dobController = '';


  //as a doctor
  final aboutController = TextEditingController();
  final addressController = TextEditingController();
  String categoryController = '';
  final ratingController = TextEditingController();
  final serviceController = TextEditingController();
  final phoneController = TextEditingController();
  final timingController = TextEditingController();



  UserCredential? userCredential;


  isUserAlreadyLoggedIn() async{
    await FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user != null){
        Get.offAll(() => HomeView());
      }else{
        Get.offAll(() => LoginView());
      }
    }
    );
  }


  Future<String> loginUser() async{
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      return '';
    }
    on FirebaseAuthException catch(error) {
      return error.code;
    }
  }

  Future<String> signupUser(bool isDoctor) async{
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      await storeUserData(userCredential!.user!.uid, fullNameController.text, emailController.text, isDoctor);
      return "";
    } on FirebaseAuthException catch(error) {
      return error.code;
    }
  }

storeUserData(String uid, String fullname, String email, bool isDoctor) async{
  var store = FirebaseFirestore.instance.collection(isDoctor ? 'doctors' : 'users').doc(uid);
  if(isDoctor){
    await store.set({
      'fullname' : fullNameController.text,
      'docAbout' : aboutController.text,
      'docAddress' : addressController.text,
      'docCategory' : categoryController,
      'docRating' : ratingController.text,
      'docService' : serviceController.text,
      'docPhone' : phoneController.text,
      'docTiming' : timingController.text,
      'docId' : FirebaseAuth.instance.currentUser?.uid,
      'email' :   emailController.text,
    });
  }else{
    await store.set({
      'fullname': fullname,
      'email': email,
      'contact': contactController.text,
      'location': locationController.text,
      'allergies': allergiesController.text,
      'bloodType':bloodGroupController.text,
      'dateOfBirth': dobController.text,

    });

  }
  }

signOut() async{
    await FirebaseAuth.instance.signOut();
}
  String getCurrentUserId() {
    // Your implementation to get the current user's ID (uid)
    // Replace the following line with the actual logic from FirebaseAuth.
    return FirebaseAuth.instance.currentUser?.uid ?? '';
  }

}