import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/views/home_view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    loadApplication();
  }

  void loadApplication() async {
    /* this method waits for 3 seconds
    * and then checks if there is a user logged in
    * and if true, navigates to the landing page
    * else it navigates to the on-boarding page
    */
    var user = FirebaseAuth.instance.currentUser;
    final SharedPreferences pref = await SharedPreferences.getInstance();

    await Future.delayed(const Duration(seconds: 3));

    if(!context.mounted) return;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => user != null ?
        Home(isDoctor: pref.getBool('isDoctor') ?? false) : const OnBoardingScreen()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1055E5),
      body: Center(
        child: SvgPicture.asset(
          Appassets.ic_splash,
          height: 128,
          width: 128,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
