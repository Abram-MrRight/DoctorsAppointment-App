import 'package:badges/badges.dart' as badges;
import 'package:doctors_appt/beta/components/widgets.dart';
import 'package:doctors_appt/beta/constants/strings.dart';
import 'package:doctors_appt/beta/models/appointments.dart';
import 'package:doctors_appt/beta/pages/login_page.dart';
import 'package:doctors_appt/beta/pages/sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/colors.dart';
import '../utilities/providers.dart';
import 'appointment_details_page.dart';

class AppointmentsPage extends StatefulWidget {
  bool isDoctor;
  AppointmentsPage({super.key, required this.isDoctor});
  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Sidebar(),
          appBar: AppBar(
            backgroundColor: Provider.of<ThemeProvider>(context).currentThemeData?.primaryColor,
            foregroundColor: Provider.of<ThemeProvider>(context).currentThemeData?.canvasColor,
            leading: Builder(
              builder: (context) => IconButton(
                icon: CircleAvatar(
                  backgroundImage: AssetImage(
                      noImage
                  ),
                  radius: 16,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            title: text('Appointments'),
            actions: [IconButton(
              onPressed: (){
                // Get.to(()=> NotificationsView());
              },
              icon:  badges.Badge(
                badgeContent: const Text('3', style: TextStyle(color: light, fontSize: 12),
                ),
                position: badges.BadgePosition.topEnd(top: -15, end:  -12),
                child:  const Icon(IconlyBroken.notification),
              ),
            ),
              16.widthBox,
              IconButton(
                  onPressed: () async{
                    // Show confirmation dialog
                    await Get.defaultDialog(
                        title: "Do you want to logout?",
                        content: Container(),
                        textConfirm: "Yes",
                        textCancel: "No",
                        onConfirm: (){
                          FirebaseAuth.instance.signOut();
                          Get.offAll(() => LoginPage());
                        },
                        onCancel: (){

                        }
                    );
                  },
                  icon: const Icon(Icons.logout_rounded)
              ),
            ],
            bottom: TabBar(
              dividerColor: light,
              labelColor: light,
              indicatorColor: light,
              unselectedLabelColor: light.withOpacity(0.5),
              tabs: const [
                Tab(text: "Upcoming"),
                Tab(text: "Cancelled"),
                Tab(text: "Past"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FutureBuilder<List<AppointmentModel>>(
                future: widget.isDoctor ? AppointmentService().getAppointmentsForDoctor(
                    FirebaseAuth.instance.currentUser!.email!
                ) :
                AppointmentService().getAppointmentsForPatient(
                  FirebaseAuth.instance.currentUser!.email!
                ),
                builder: (BuildContext context, AsyncSnapshot<List<AppointmentModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: progressIndicator());
                  }
                  else if (snapshot.hasData) {
                    var appointments = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: appointments!.length, // Use actual data length
                        itemBuilder: (BuildContext context, index) {
                          var appointment = appointments[index];
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              GestureDetector(
                                child: Card(
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Appointment date",
                                          style: TextStyle(
                                              fontSize: 12
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              appointment.date,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 12
                                              ),
                                            ),
                                            16.widthBox,
                                            Text(
                                              appointment.time,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 12
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(color: Colors.grey[300]),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  noImage
                                              ),
                                              radius: 36,
                                            ),
                                            16.widthBox,
                                            futureAppointment(appointment, widget.isDoctor)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  navigateTo(context, AppointmentDetailsPage(appointment: appointment, isDoctor: widget.isDoctor));
                                },
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon:  Icon(
                                      Icons.edit,
                                    ),
                                    onPressed: ()  async{
                                      await Get.defaultDialog(
                                          title: "Do you want to reschedule the appointment?",
                                          content: Container(),
                                          textConfirm: "Yes",
                                          textCancel: "No",
                                          onConfirm: () async {
                                            final docSnapshot = appointment;
                                            // final dialog = AppointmentEditDialog(); // Pass index to constructor
                                            // await showDialog(context: context, builder: (context) => dialog);
                                            setState(() {}); // Trigger a rebuild to fetch updated data
                                          },
                                          onCancel: (){

                                          }
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                    ),
                                    onPressed: () async {
                                      // Show confirmation dialog
                                      await Get.defaultDialog(
                                        title: "Do you want to delete the appointment?",
                                        content: Container(), // You can customize the content if needed
                                        textConfirm: "Yes",
                                        textCancel: "No",
                                        onConfirm: () async {
                                          final docSnapshot = appointment;
                                          // Call the method to delete the appointment
                                          // await DeleteAppointment.deleteAppointment(currentAppointment.id);
                                          Navigator.of(context).pop(); // Close the dialog after deleting
                                        },
                                        onCancel: () {
                                          // Do nothing if the user clicks No
                                        },
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    );
                  }
                  else if (!snapshot.hasData) {
                    return Center(
                      child: text('You have no appointments!', color: Colors.grey, size: 16, weight: FontWeight.bold),
                    );
                  }
                  else {
                    return Center(child: text('An unknown error occurred!', color: Colors.grey, size: 16, weight: FontWeight.bold));
                  }
                },
              ),
              FutureBuilder<List<AppointmentModel>>(
                future: AppointmentService().getAppointmentsForUserByStatus(
                    FirebaseAuth.instance.currentUser!.uid, 'cancelled'),
                builder: (BuildContext context, AsyncSnapshot<List<AppointmentModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: text('You have no cancelled appointments!',
                          color: Colors.grey, size: 16, weight: FontWeight.bold),
                    );
                  }
                  else if (snapshot.connectionState == ConnectionState.active) {
                    return Center(child: progressIndicator());
                  }
                  else if (snapshot.hasData) {
                    var appointments = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: appointments!.length, // Use actual data length
                        itemBuilder: (BuildContext context, index) {
                          var appointment = appointments[index];
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              GestureDetector(
                                child: Card(
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Appointment date",
                                          style: TextStyle(
                                              fontSize: 12
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              appointment.date,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 12
                                              ),
                                            ),
                                            16.widthBox,
                                            Text(
                                              appointment.time,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 12
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(color: Colors.grey[300]),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  noImage
                                              ),
                                              radius: 36,
                                            ),
                                            16.widthBox,
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  appointment.doctor,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                      color: blueTheme
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Get.to(() =>  AppointmentDetailsView( doc: currentAppointment));
                                },
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon:  Icon(
                                      Icons.edit,
                                    ),
                                    onPressed: ()  async{
                                      await Get.defaultDialog(
                                          title: "Do you want to reschedule the appointment?",
                                          content: Container(),
                                          textConfirm: "Yes",
                                          textCancel: "No",
                                          onConfirm: () async {

                                          },
                                          onCancel: (){

                                          }
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                    ),
                                    onPressed: () async {
                                      // Show confirmation dialog
                                      await Get.defaultDialog(
                                        title: "Do you want to delete the appointment?",
                                        content: Container(), // You can customize the content if needed
                                        textConfirm: "Yes",
                                        textCancel: "No",
                                        onConfirm: () async {

                                        },
                                        onCancel: () {

                                        },
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    );
                  }
                  else {
                    return Center(
                      child: text('Unknown Error!',
                          color: Colors.grey, size: 16, weight: FontWeight.bold),
                    );
                  }
                },
              ),
              FutureBuilder<List<AppointmentModel>>(
                future: AppointmentService().getAppointmentsForUserByStatus(
                    FirebaseAuth.instance.currentUser!.uid, 'completed'),
                builder: (BuildContext context, AsyncSnapshot<List<AppointmentModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: text('You have no past appointments!',
                          color: Colors.grey, size: 16, weight: FontWeight.bold),
                    );
                  }
                  else if (snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: progressIndicator());
                  }
                  else if (snapshot.hasData) {
                    var appointments = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: appointments!.length, // Use actual data length
                        itemBuilder: (BuildContext context, index) {
                          var appointment = appointments[index];
                          return Card(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Appointment date",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        appointment.date,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 12
                                        ),
                                      ),
                                      16.widthBox,
                                      Text(
                                        appointment.time,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 12
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(color: Colors.grey[300]),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            noImage
                                        ),
                                        radius: 36,
                                      ),
                                      16.widthBox,
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            appointment.doctor,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: blueTheme
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  else {
                    return Center(
                      child: text('Unknown Error!',
                          color: Colors.grey, size: 16, weight: FontWeight.bold),
                    );
                  }
                },
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {

            },
            child: Icon(Icons.add, color: light),
            backgroundColor: blueTheme,
          ),
        ),
      ),
    );
  }


}
