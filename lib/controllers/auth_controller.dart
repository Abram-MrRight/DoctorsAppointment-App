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
  //final confirmPassword = TextEditingController();

  //as a doctor
  final aboutController = TextEditingController();
  final addressController = TextEditingController();
  final categoryController = TextEditingController();
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


  loginUser() async{
    userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
  }

  signupUser() async{
  userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);

  await storeUserData(userCredential!.user!.uid, fulnameController.text, emailController.text);
}

storeUserData(String uid, String fullname, String email) async{
  var store = FirebaseFirestore.instance.collection('users').doc(uid);
  await store.set({'fullname': fullname, 'email': email});
}

signOut() async{
    await FirebaseAuth.instance.signOut();
}
}