import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appt/views/appointment_details_view/appointment_details_view.dart';
import 'package:doctors_appt/views/login_view/login_view.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../consts/consts.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/myAppointment_controller.dart';
import 'package:badges/badges.dart' as badges;

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {


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
              size: AppSizes.size16.toDouble(),
            ),
            actions: [IconButton(
              onPressed: (){},
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
                    var confirm = await Get.defaultDialog(
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
                        itemBuilder: (BuildContext context, int index) {
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
                                  // child: ListTile(
                                  //   onTap: () {
                                  //     Get.to(() =>  AppointmentDetailsView(
                                  //       doc: data[index],
                                  //     ));
                                  //   },
                                  //   leading: CircleAvatar(
                                  //     child: Image.asset(Appassets.imgSignup),
                                  //   ),
                                  //   title: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Column(
                                  //         crossAxisAlignment: CrossAxisAlignment.start,
                                  //         children: [
                                  //           const Text(
                                  //             "Appointment date",
                                  //             style: TextStyle(
                                  //               fontSize: 12
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             data[index]['appDay'],
                                  //             style: TextStyle(
                                  //               fontWeight: FontWeight.w900,
                                  //               fontSize: 12
                                  //             ),
                                  //           )
                                  //         ],
                                  //       )
                                  //     ],
                                  //   ),
                                  //   // title: AppStyles.bold(title:"Doctor Name"),
                                  //   subtitle: AppStyles.normal(
                                  //     title: "${data[index]['appDay']} - ${data[index]['appTime']}",
                                  //     color: AppColors.textColor.withOpacity(0.5),
                                  //   ),
                                  // ),
                                ),
                                onTap: () {
                                  Get.to(() =>  AppointmentDetailsView(
                                    doc: data[index],
                                  ));
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.more_vert_outlined,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Cancel Appointment",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.blueTheme,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        content: const Text(
                                          "If you wish to postpone your appointment, you may need to click reschedule instead",
                                          style: TextStyle(

                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Cancel', style: TextStyle(color: AppColors.whiteColor),),
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                              ),
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8
                                              )
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Reschedule', style: TextStyle(color: AppColors.whiteColor),),
                                            style: TextButton.styleFrom(
                                                backgroundColor: AppColors.blueTheme,
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8
                                                )
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                },
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
        ),
      ),
    );
  }
}
