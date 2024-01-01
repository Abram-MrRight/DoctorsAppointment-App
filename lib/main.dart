import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
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
      theme:ThemeData(
        fontFamily: AppFonts.nunitoLight,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF1055E5)
        )
      ),
      debugShowCheckedModeBanner:false ,
      home: const SplashScreen(),
    );
  }
}

