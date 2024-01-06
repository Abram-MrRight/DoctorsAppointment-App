import 'package:doctors_appt/views/appointment_view/appointment_view.dart';
import 'package:doctors_appt/views/category/category_view.dart';
import 'package:doctors_appt/views/doctor_views/patient_records_view.dart';
import 'package:doctors_appt/views/home_view/doctors_home_view.dart';
import 'package:doctors_appt/views/home_view/home_view.dart';
import 'package:doctors_appt/views/notifications/notifications_view.dart';

import '../../consts/consts.dart';

class Home extends StatefulWidget {
  int selectedIndex;
  bool isDoctor;

  Home({
    required this.isDoctor,
    super.key,
    this.selectedIndex = 0
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List screenList = [
      widget.isDoctor ? DoctorHomePage() : const HomeView(),
      const AppointmentView(),
      widget.isDoctor ? const PatientRecordsPage() : const CategoryView(),
      const NotificationsView(),
    ];

    return Scaffold(
      body: screenList.elementAt(widget.selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        backgroundColor: AppColors.blueTheme,
        type:BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: AppColors.whiteColor,

        ),
        selectedIconTheme: IconThemeData(
          color: AppColors.whiteColor,
        ),
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
              icon: widget.isDoctor ? const Icon(Icons.receipt) : const Icon(Icons.category),
              label: widget.isDoctor ? "Records" : "Categories"
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.mail), label:"Notifications"),
        ],
      ),
    );
  }
}
