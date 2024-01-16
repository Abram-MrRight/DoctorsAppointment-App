import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appt/beta/constants/strings.dart';
import 'package:doctors_appt/beta/models/appointments.dart';
import 'package:doctors_appt/beta/models/reviews.dart';
import 'package:doctors_appt/beta/pages/appointment_details_page.dart';
import 'package:doctors_appt/beta/pages/category_details_page.dart';
import 'package:doctors_appt/beta/pages/doctor_details.dart';
import 'package:doctors_appt/beta/pages/root_page.dart';
import 'package:doctors_appt/beta/utilities/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/colors.dart';
import '../constants/compound_data.dart';
import '../models/users.dart';
import '../pages/doctor_home_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/settings_page.dart';

Widget progressIndicator () {
  return const CircularProgressIndicator(
    color: Colors.white,
    backgroundColor: Colors.blue,
  );
}

Widget authButton (BuildContext context, String buttonText, bool condition, Function()? onTap) {
  return SizedBox(
    width: context.screenWidth,
    height: 44,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: const Color(0xFF1055E5),
          foregroundColor: Colors.white,
        ),
        onPressed: onTap,
        child: condition ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [progressIndicator(), 16.widthBox, buttonText.text.make()],
        ) : buttonText.text.make()
    ),
  );
}

void toast(String message, {Color? bgColor = blueTheme,
  Color? fgColor = light, ToastGravity? position = ToastGravity.CENTER}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: bgColor,
    textColor: light,
    gravity: position
  );
}

void navigateTo(BuildContext context, Widget page, {String goBack = ''}) {
  if (goBack.isEmpty) Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

Text text(
    String content, {Color? color, FontWeight? weight, double? size, FontStyle? style,
    TextOverflow? overflow, int? maxLines}
    ) {
  return Text(content, style: TextStyle(color: color, fontWeight: weight,
              fontSize: size, fontStyle: style, overflow: overflow));
}

Widget futureUser() {
  return FutureBuilder<UserModel?>(
    future: UserService().getUser(),
    builder: (context, AsyncSnapshot<UserModel?> snapshot) {
      if (!snapshot.hasData) {
        return const Text('Welcome');
      }
      else if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.waiting) {
        return progressIndicator();
      }
      else if (snapshot.hasData) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome ${snapshot.data!.username}'),
            text('How are you feeling today?', size: 14)
          ],
        );
      }
      else {
        return const Text('???');
      }
    },
  );
}

Widget futureUserSidebar() {
  return FutureBuilder<UserModel?>(
    future: UserService().getUser(),
    builder: (context, AsyncSnapshot<UserModel?> snapshot) {
      if (!snapshot.hasData) {
        return const Text('Doctor\'s Appointment');
      }
      else if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.waiting) {
        return progressIndicator();
      }
      else if (snapshot.hasData) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${snapshot.data!.fullName}'),
            text('${snapshot.data!.email}', size: 14)
          ],
        );
      }
      else {
        return const Text('???');
      }
    },
  );
}

Widget popularDoctor() {
  return FutureBuilder(
      future: UserService().getDoctors(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var doctors = snapshot.data;
          return SizedBox(
            height: 200,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: doctors?.length ?? 0,
                itemBuilder: (BuildContext context, int index){
                  UserModel doctor = doctors[index];
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      GestureDetector(
                        onTap: () {
                          navigateTo(context, DoctorDetail(doctor: doctor));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)
                          ),
                          margin: const EdgeInsets.all(8.0),
                          color: blueTheme,
                          child: SizedBox(
                            width: 140,
                            height: 172,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16)
                                    ),
                                    child: Image.asset(
                                      noImage,
                                      height: double.infinity, // Adjust the height of the image
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doctor.fullName ?? '',
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        doctor.speciality ?? '',
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: IconButton(
                            icon:  const Icon(
                              Icons.favorite_outline,
                              color: Colors.red,
                              size: 24.0,
                            ),
                            onPressed: () {

                            },
                          ),
                        ),
                      )
                    ],
                  );
                }
            ),
          );
        }
      }
  );
}

Widget futureDoctor(BuildContext context) {
  return FutureBuilder<List<UserModel>?>(
    future: UserService().getDoctors(),
    builder: (context, AsyncSnapshot<List<UserModel>?> snapshot) {
      if (snapshot.hasError || !snapshot.hasData) {
        print('error or no data..................');
        snapshot.error.printError();
        return Text('${snapshot.error}');
      }
      else if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active) {
        print('loadin..................');
        return progressIndicator();
      }
      else {
        List<UserModel>? doctors = snapshot.data;
        return SizedBox(
          height: doctors!.length * 256,
          child: ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              UserModel doctor = doctors[index];
              return GestureDetector(
                onTap: () {
                  navigateTo(context, DoctorDetail(doctor: doctor));
                },
                child: Container(
                  width: double.infinity,
                  height: 156,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      color: light,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ]
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 36,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(36),
                                      child: Image.asset(
                                          noImage
                                      ),
                                    ),
                                  ),
                                  20.widthBox,
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doctor.fullName!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          doctor.speciality!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          doctor.address!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {

                                  },
                                  icon: const Icon(
                                    Icons.favorite_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ]
                        ),
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Rating',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                              4.widthBox,
                              Text(
                                doctor.rating,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Consultation Fee',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                              4.widthBox,
                              Text(
                                doctor.consultationFee!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Experience',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                              4.widthBox,
                              Text(
                                doctor.experience!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
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
    },
  );
}

Widget proceedButton(String buttonText, Function() onTap, {bool? isConnecting}) {
  return SizedBox(
    width: double.infinity,
    height: 44,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: blueTheme,
          foregroundColor: light,
        ),
        onPressed: onTap,
        child: isConnecting == null || !isConnecting ? text(buttonText, color: light, weight: FontWeight.bold) :
            progressIndicator()
    ),
  );
}

Widget buildTimeSlotButton(String timeSlot, List<AppointmentModel> appointments) {
  bool isSlotAvailable = !appointments.any((appointment) => appointment.time == timeSlot);

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: OutlinedButton(
      onPressed: isSlotAvailable
          ? () {
        inputControllers['appointmentTime']!.text = timeSlot;
        toast('You\'ve selected ${inputControllers['date']!.text} at ${
            inputControllers['appointmentTime']!.text}');
      }
          : null,
      style: ButtonStyle(
        backgroundColor: isSlotAvailable
            ? MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              // Pressed state
              return blueTheme;
            } else if (states.contains(MaterialState.disabled)) {
              // Disabled state
              return Colors.grey;
            }
            // Default state
            return light;
          },
        )
            : MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) => Colors.grey,
        ),
        foregroundColor: isSlotAvailable
            ? MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              // Disabled state
              return light;
            }
            // Default state
            return dark;
          },
        )
            : MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) => Colors.white,
        ),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
              (Set<MaterialState> states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0)
            );
          },
        ),
      ),
      child: Text(timeSlot),
    ),
  );
}

Widget futureSlots(UserModel doctor, String date) {
  return FutureBuilder<List<AppointmentModel>>(
    future: AppointmentService().getAppointmentsForUserByDate(doctor.email!, date),
    builder: (context, AsyncSnapshot<List<AppointmentModel>> snapshot) {
      if (snapshot.connectionState == ConnectionState.active ||
          snapshot.connectionState == ConnectionState.waiting) {
        return progressIndicator();
      } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
        return const Text('Data N/A');
      } else if (snapshot.hasError) {
        return Text(snapshot.error.toString());
      } else if (snapshot.hasData) {
        List<AppointmentModel> appointments = snapshot.data!;
        appointments.removeWhere((element) => element.date != date);
        return SizedBox(
          height: 32,
          child: ListView.builder(
            itemCount: timeSlots.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return buildTimeSlotButton(timeSlots[index], appointments);
            },
          ),
        );
      } else {
        return const Text('Unknown Issue!');
      }
    },
  );
}

Widget futurePhone() {
  return FutureBuilder<UserModel?>(
      future: UserService().getUser(),
      builder: (context, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.hasData) {
          inputControllers['phone']!.text = snapshot.data!.phone!;
          return TextFormField(
            controller: inputControllers['phone'],
            onChanged: (value) {
              inputControllers['phone']!.text = value;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              icon: Icon(Icons.phone),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Phone number field is required';
              }
              return null;
            },
          );
        }
        else {
          return TextFormField(
            initialValue: FirebaseAuth.instance.currentUser!.phoneNumber,
            decoration: InputDecoration(
                labelText: 'Phone Number',
                icon: const Icon(Icons.phone),
                hintText: FirebaseAuth.instance.currentUser!.phoneNumber ?? ''
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Phone number field is required';
              }
              return null;
            },
          );
        }
      }
  );
}

Widget carouselCategory() {
  return SizedBox(
    height: 80,
    child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: specialistTypes.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              navigateTo(context, CategoryDetailsPage(specialistType: specialistTypes[index]));
            },
            child: Container(
              width: 108,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: blueTheme,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(right: 8),
              child: Column(
                children: [
                  const Icon(Icons.category_outlined, color: light,),
                  5.heightBox,
                  text(specialistTypes[index], color: light, size: 12, overflow: TextOverflow.ellipsis)
                ],
              ),
            ),
          );
        }
    ),
  );
}

Widget futureDoctorsNearYou() {
  return FutureBuilder<List<UserModel>>(
    future: UserService().getDoctors(),
    builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
      if (!snapshot.hasData) {
        print('no data..................');
        snapshot.error.printError();
        return const Text('No data found!');
      }
      else if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active) {
        print('loading doctors..................');
        return progressIndicator();
      }
      else if (snapshot.hasData) {
        List<UserModel>? doctors = snapshot.data;
        return SizedBox(
          height: snapshot.data!.length * 180,
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var doctor = doctors![index];
              return GestureDetector(
                onTap: () {
                  navigateTo(context, DoctorDetail(doctor: doctor));
                },
                child: Container(
                  width: double.infinity,
                  height: 156,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      color: light,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ]
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 36,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(36),
                                      child: Image.asset(
                                          noImage
                                      ),
                                    ),
                                  ),
                                  20.widthBox,
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${doctor.fullName}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          '${doctor.speciality}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          '${doctor.location}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          '${doctor.address}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {

                                  },
                                  icon: const Icon(
                                    Icons.favorite_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ]
                        ),
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Rating',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                              4.widthBox,
                              Text(
                                '${doctor.rating}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Consultation Fees',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                              4.widthBox,
                              const Text(
                                'UGX 4,000',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Experience',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                              4.widthBox,
                              const Text(
                                '14 years',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
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
        return Center(child: text('An unknown error occurred!'));
      }
    },
  );
}

Widget futureDone() {
  return FutureBuilder<UserModel?>(
    future: UserService().getUser(),
    builder: (context, AsyncSnapshot<UserModel?> snapshot) {
      if (!snapshot.hasData) {
        return const Text('Welcome');
      }
      else if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.waiting) {
        return progressIndicator();
      }
      else if (snapshot.hasData) {
        return proceedButton('Done', () {
          navigateTo(context, RootPage(currentUser: snapshot.data!, selectedIndex: 1));
        });
      }
      else {
        return const Text('???');
      }
    },
  );
}

Widget futureAppointment(AppointmentModel appointment, bool isDoctor) {
  return FutureBuilder<UserModel>(
    future: isDoctor ? UserService().getUserByEmail(appointment.patient) :
    UserService().getUserByEmail(appointment.doctor),
    builder: (context, AsyncSnapshot<UserModel> snapshot) {
      if (!snapshot.hasData) {
        return const Text('N/A');
      }
      else if (snapshot.connectionState == ConnectionState.active ||
          snapshot.connectionState == ConnectionState.waiting) {
        return progressIndicator();
      }
      else if (snapshot.hasData) {
        UserModel? party = snapshot.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(party!.fullName!),
            5.heightBox,
            text('${isDoctor ? appointment.phone : party.address}, ${party.location}'),
            5.heightBox,
            appointment.message != null ? text('Concern: ${appointment.message!}') : Container(),
          ],
        );
      }
      else {
        return const Text('Unknown error has occurred. Please try again');
      }
    },
  );
}

Widget futureAppointmentDetail(AppointmentModel appointment, bool isDoctor) {
  return FutureBuilder<UserModel>(
    future: isDoctor ? UserService().getUserByEmail(appointment.patient) :
    UserService().getUserByEmail(appointment.doctor),
    builder: (context, AsyncSnapshot<UserModel> snapshot) {
      if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
        return const Text('N/A');
      }
      else if (snapshot.connectionState == ConnectionState.active ||
          snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: progressIndicator());
      }
      else if (snapshot.hasData) {
        UserModel? party = snapshot.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(appointment.date, size: 20, color: blueTheme, weight: FontWeight.bold),
            12.heightBox,
            text(appointment.time, size: 18, color: Colors.orange, weight: FontWeight.bold),
            12.heightBox,
            text(party!.fullName!, size: 18, color: blueTheme, weight: FontWeight.bold),
            12.heightBox,
            text('${isDoctor ? party.location : '${party.address}, ${party.location}'}'),
            12.heightBox,
            appointment.message != null ? text('Concern: ${appointment.message!}') : Container(),
            12.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text('Call if an emergency: ${party.phone}'),
                12.widthBox,
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                    color: success
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.phone),
                    color: light,
                    onPressed: () {launchUrl(Uri.parse(party.phone!));},
                  )
                )
              ],
            ),
            36.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      // cancel appointment
                    },
                    child: text('CANCEL', color: danger, weight: FontWeight.bold, size: 24)
                ),
                24.widthBox,
                TextButton(
                    onPressed: () {
                      // reschedule appointment
                    },
                    child: text('RESCHEDULE', color: blueTheme, weight: FontWeight.bold, size: 24)
                ),
              ],
            )
          ],
        );
      }
      else {
        return const Text('Unknown error has occurred. Please try again');
      }
    },
  );
}

Widget buildAppointmentCard(BuildContext context, String patientName, String date, String time) {
  return Card(
    color: Provider.of<ThemeProvider>(context).currentThemeData?.splashColor.withOpacity(0.9),
    child: ListTile(
      title: Text('Patient: $patientName'),
      subtitle: Text('Time: $date - $time'),
      onTap: () {
        // Add functionality for tapping on an appointment
      },
    ),
  );
}

Widget futureUpcomingAppointments() {
  return FutureBuilder<List<AppointmentModel>>(
    future: AppointmentService().getAppointmentsForDoctor(FirebaseAuth.instance.currentUser!.email!, limit: 2),
    builder: (context, AsyncSnapshot<List<AppointmentModel>> snapshot) {
      if (!snapshot.hasData) {
        snapshot.error.printError();
        return const Text('No data found!');
      }
      else if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active) {
        return Center(child: progressIndicator());
      }
      else if (snapshot.data!.isEmpty) {
        return text('You don\'t have any appointments available');
      }
      else if (snapshot.hasData) {
        List<AppointmentModel>? appointments = snapshot.data;
        return SizedBox(
          height: appointments!.length * 72,
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var appointment = appointments[index];
              return GestureDetector(
                onTap: () {
                  Get.to(
                          () => AppointmentDetailsPage(appointment: appointment, isDoctor: true)
                  );
                },
                child: buildAppointmentCard(
                  context, appointment.patient,
                  DateFormat('MMMM d, y').format(DateTime.parse(appointment.date)),
                  appointment.time
                ),
              );
            },
          ),
        );
      }
      else {
        return Center(child: text('An unknown error occurred!'));
      }
    },
  );
}

Widget futureDrawerAccount() {
  return FutureBuilder<UserModel?>(
      future: UserService().getUser(),
      builder: (context, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: progressIndicator());
        }
        else if (snapshot.hasData) {
          UserModel? user = snapshot.data;
          return UserAccountsDrawerHeader(
            accountName: text(user!.fullName!, weight: FontWeight.w900),
            accountEmail: text(user.email!),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                  noImage
              ),
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    blueTheme,
                    Colors.pinkAccent
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
              ),
            ),
          );
        }
        else if (!snapshot.hasData) {
          return text('User data N/A', color: light);
        }
        else {
          return const Text('An unknown error is preventing display of user information');
        }
      },
    );
}

Widget futureTotalPatients(UserModel doctor) {
  return FutureBuilder<List<AppointmentModel>>(
    future: AppointmentService().getAppointmentsForDoctor(
        doctor.email!),
    builder: (context, AsyncSnapshot<List<AppointmentModel>> snapshot) {
      if (!snapshot.hasData) {
        print('no data..................');
        snapshot.error.printError();
        return text('N/A', color: light);
      }
      else if (snapshot.connectionState == ConnectionState.waiting ||
          snapshot.connectionState == ConnectionState.active) {
        print('loading appointments..................');
        return Center(child: progressIndicator());
      }
      else if (snapshot.hasData) {
        Set patients = {};
        List<AppointmentModel> uniqueAppointments = [];
        List<AppointmentModel>? appointments = snapshot.data;
        for (var appointment in appointments!) {
          if (!patients.contains(appointment.patient)) {
            patients.add(appointment.patient);
            uniqueAppointments.add(appointment);
          }
        }
        return text(uniqueAppointments.length.toString(), size: 16, weight: FontWeight.bold, color: light);;
      }
      else {
        return Center(child: text('An unknown error occurred!'));
      }
    },
  );
}

Widget futureTotalReviews(UserModel doctor) {
  return FutureBuilder<List<ReviewModel>>(
    future: ReviewService().getReviewsForDoctor(doctor.email!),
    builder: (context, AsyncSnapshot<List<ReviewModel>> snapshot) {
      if (!snapshot.hasData) {
        print('no data..................');
        snapshot.error.printError();
        return text('N/A', color: light);
      }
      else if (snapshot.connectionState == ConnectionState.waiting ||
          snapshot.connectionState == ConnectionState.active) {
        print('loading appointments..................');
        return Center(child: progressIndicator());
      }
      else if (snapshot.hasData) {
        List<ReviewModel>? reviews = snapshot.data;
        return text(reviews!.length.toString(), size: 16, weight: FontWeight.bold, color: light);;
      }
      else {
        return Center(child: text('An unknown error occurred!'));
      }
    },
  );
}

