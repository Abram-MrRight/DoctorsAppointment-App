import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appt/views/appointment_details_view/appointment_details_view.dart';
import 'package:doctors_appt/views/appointment_view/delete_appointment.dart';
import 'package:doctors_appt/views/book_appointment/book_appointment.dart';
import 'package:doctors_appt/views/login_view/login_view.dart';
import 'package:doctors_appt/views/notifications/notifications_view.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../consts/consts.dart';
import 'package:get/get.dart';
import 'appointment_edit.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/myAppointment_controller.dart';
import 'package:badges/badges.dart' as badges;


class AppointmentView extends StatefulWidget {

  Map<String, dynamic>? doc;
  AppointmentView({super.key, required this.doc});



  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {

  late BuildContext parentContext; // Declare parentContext

  @override
  void initState() {
    super.initState();
    parentContext = context; // Initialize parentContext
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MyAppointmentController());
    var controller2 = Get.put(AuthController());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppColors.bgDarkColor,
          appBar: AppBar(
            backgroundColor: AppColors.blueTheme,
            foregroundColor: AppColors.whiteColor,
            title: AppStyles.bold(
              title: "Appointments",
              color: AppColors.whiteColor,
              size: AppSizes.size18.toDouble(),
            ),
            actions: [IconButton(
              onPressed: (){
                Get.to(()=> NotificationsView());
              },
              icon:  badges.Badge(
                badgeContent: const Text('3', style: TextStyle(color: Colors.white, fontSize: 12),
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
                        AuthController().signOut();
                        Get.offAll(() => const LoginView());
                      },
                      onCancel: (){

                      }
                    );
              },
                  icon: const Icon(Icons.logout_rounded)
              ),
            ],
            bottom: TabBar(
              dividerColor: AppColors.whiteColor,
              labelColor: AppColors.whiteColor,
              indicatorColor: AppColors.whiteColor,
              unselectedLabelColor: AppColors.whiteColor.withOpacity(0.5),
              tabs: const [
                Tab(text: "Upcoming"),
                Tab(text: "Cancelled"),
                Tab(text: "Past"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FutureBuilder<QuerySnapshot>(
                future: controller.getAppointments(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var data = snapshot.data!.docs;

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: data.length, // Use actual data length
                        itemBuilder: (BuildContext context, index) {
                          var currentAppointment = data[index];
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
                                              data[index]['appDay'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 12
                                              ),
                                            ),
                                            16.widthBox,
                                            Text(
                                              data[index]['appTime'],
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
                                                Appassets.imgSignup
                                              ),
                                              radius: 36,
                                            ),
                                            16.widthBox,
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                 controller2.emailController.value.text,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    color: AppColors.blueTheme
                                                  ),
                                                ),
                                                8.heightBox,
                                                const Text(
                                                  'Doctor\'s Speciality',
                                                  style: TextStyle(
                                                      fontSize: 14
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
                                  Get.to(() =>  AppointmentDetailsView( doc: currentAppointment));
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
                                            final docSnapshot = snapshot.data!.docs[index];
                                            final dialog = AppointmentEditDialog(documentId: docSnapshot.id); // Pass index to constructor
                                            await showDialog(context: context, builder: (context) => dialog);
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
                                          final docSnapshot = snapshot.data!.docs[index];
                                          // Call the method to delete the appointment
                                           await DeleteAppointment.deleteAppointment(currentAppointment.id);
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
                },
              ),
              Center(
                child: Icon(
                  Icons.hourglass_empty_outlined,
                  size: 128,
                  color: Colors.grey.withOpacity(0.25),
                ),
              ),
              Center(
                child: Icon(
                  Icons.hourglass_empty_outlined,
                  size: 128,
                  color: Colors.grey.withOpacity(0.25),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {

              Get.to(() =>  BookAppointment(
                docId: 'docId',
                fullname: 'fullname',
              ));
              },
            child: Icon(Icons.add),
            backgroundColor: AppColors.blueTheme,
          ),
        ),
      ),
    );
  }


}
