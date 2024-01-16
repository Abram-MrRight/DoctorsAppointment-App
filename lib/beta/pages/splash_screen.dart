import '../constants/strings.dart';
import '../models/users.dart';
import '../pages/onboarding_screen.dart';
import '../pages/root_page.dart';
import '../utilities/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserModel? currentUser;
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    User? user = FirebaseAuth.instance.currentUser;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel? currentUser = await UserService().getUser();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => user == null ?
            const OnboardingScreen() :
            RootPage(isDoctor: prefs.getBool('isDoctor') != null ? prefs.getBool('isDoctor')! : false, currentUser: currentUser!)),
                (route) => false
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          splashIcon,
          theme: SvgTheme(
            currentColor: Provider.of<ThemeProvider>(context).currentThemeData!.primaryColor,
            xHeight: 36
          ),
          color: Provider.of<ThemeProvider>(context).currentThemeData!.primaryColor,
          height: 128,
          width: 128,
        ),
      ),
    );
  }
}
