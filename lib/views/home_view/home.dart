import 'package:doctors_appt/views/appointment_view/appointment_view.dart';
import 'package:doctors_appt/views/category/category_view.dart';
import 'package:doctors_appt/views/home_view/home_view.dart';
import 'package:doctors_appt/views/settings/settings_View.dart';

import '../../consts/consts.dart';

class Home extends StatefulWidget {
  int selectedIndex;

  Home({
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

  List screenList = [
    const HomeView(),
    const AppointmentView(),
    const CategoryView(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
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
