import '../pages/appointments_page.dart';
import '../pages/categories_page.dart';
import '../pages/home_page.dart';
import '../pages/notifications_page.dart';
import '../pages/records_page.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/users.dart';
import 'doctor_home_page.dart';

class RootPage extends StatefulWidget {
  int selectedIndex;
  bool? isDoctor;
  final UserModel currentUser;
  RootPage({super.key, this.selectedIndex = 0, this.isDoctor,
  required this.currentUser});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  UserModel? currentUser;
  @override
  void initState() {
    super.initState();
  }

  Future<void> initialize() async {
    currentUser = await UserService().getUser();
  }

  @override
  Widget build(BuildContext context) {
    bool isDoctor = widget.currentUser.isDoctor as bool;
    List screenList = [
      isDoctor ? DoctorHomePage(currentUser: widget.currentUser) : const HomePage(),
      AppointmentsPage(isDoctor: isDoctor),
      isDoctor ? PatientRecordsPage() : const CategoriesPage(),
      const NotificationsPage(),
    ];
    return Scaffold(
      body: screenList.elementAt(widget.selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: light,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        backgroundColor: blueTheme,
        type:BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(color: light),
        selectedIconTheme: IconThemeData(color: light),
        currentIndex: widget.selectedIndex,
        onTap: (value){
          setState(() {
            widget.selectedIndex = value;
          });
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label:"Home"),
          const BottomNavigationBarItem(icon: Icon(Icons.book), label:"Appointments"),
          BottomNavigationBarItem(
              icon: isDoctor ? const Icon(Icons.receipt) : const Icon(Icons.category),
              label: isDoctor ? "Records" : "Categories"
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.mail), label:"Notifications"),
        ],
      ),
    );
  }
}
