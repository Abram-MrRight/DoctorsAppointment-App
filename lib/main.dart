import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/views/home_view/home.dart';
import 'package:doctors_appt/views/login_view/login.dart';
import 'package:doctors_appt/views/login_view/login_view.dart';
import 'package:doctors_appt/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/userController/userController.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme:ThemeData(fontFamily: AppFonts.nunitoLight),
      debugShowCheckedModeBanner:false ,
      home: SplashScreen(),
    );
  }
}

