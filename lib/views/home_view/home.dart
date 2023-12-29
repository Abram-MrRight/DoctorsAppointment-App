import 'package:doctors_appt/views/appointment_view/appointment_view.dart';
import 'package:doctors_appt/views/category/category_view.dart';
import 'package:doctors_appt/views/home_view/home_view.dart';
import 'package:doctors_appt/views/login_view/login_view.dart';
import 'package:doctors_appt/views/settings/settings_View.dart';
import 'package:flutter/foundation.dart';

import '../../consts/consts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  List screenList = [
    const HomeView(),
    const AppointmentView(),
    const CategoryView(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        backgroundColor: Colors.blue,
        type:BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: AppColors.whiteColor,

        ),
        selectedIconTheme: IconThemeData(
          color: AppColors.whiteColor,
        ),
        currentIndex: selectedIndex,
        onTap: (value){
        setState(() {
          selectedIndex = value;
        });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label:"Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label:"Appointment"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label:"Category"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label:"Settings"),

        ],
      ),
    );
  }
}
