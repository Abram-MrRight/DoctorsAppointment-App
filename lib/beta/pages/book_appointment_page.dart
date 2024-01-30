import '../constants/compound_data.dart';
import '../constants/strings.dart';
import '../models/appointments.dart';
import '../pages/booking_success_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

import '../components/table_calendar.dart';
import '../components/widgets.dart';
import '../constants/colors.dart';
import '../constants/compound_data.dart';
import '../models/users.dart';

class BookAppointment extends StatefulWidget {
  final UserModel doctor;
  const BookAppointment({super.key, required this.doctor});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  bool isConnecting = false;

  @override
  void initState() {
    super.initState();
    inputControllers['date']!.clear();
  }

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    bool isConnecting = false;
    RxBool isLoading = false.obs;

    return Scaffold(
      backgroundColor: light.withOpacity(0.9),
      appBar: AppBar(
        title: text('Appointment with ${widget.doctor.fullName!}', color: light, size: 16)
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundImage: AssetImage(
                          noImage
                      ),
                    ),
                    4.heightBox,
                    text(widget.doctor.fullName!, color: dark, size: 16),
                    4.heightBox,
                    text(widget.doctor.speciality!, color: dark.withOpacity(0.5), size: 12),
                    4.heightBox,
                    text(widget.doctor.consultationFee!, color: dark, size: 16)
                  ],
                ),
              ),
              10.heightBox,
              StatefulBuilder(
                builder: (context, StateSetter setState) {
                  return Column(
                    children: [
                      StatefulBuilder(
                        builder: (context, StateSetter calendarSetState) {
                          return MyCalendar(onDateSelected: (selectedDay, focusedDay) {
                            calendarSetState(() {
                              inputControllers['date']!.text = selectedDay.toString().substring(0, 10);
                            });
                            setState(() {});
                          });
                        },
                      ),
                      10.heightBox,
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Time Slots",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      4.heightBox,
                      futureSlots(widget.doctor, inputControllers['date']!.text)
                    ],
                  );
                }
              ),
              10.heightBox,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    futurePhone(),
                    10.heightBox,
                    TextField(
                      controller: inputControllers['message'],
                      decoration: InputDecoration(
                          labelText: 'Message (optional)',
                          icon: Icon(Icons.message),
                          hintText: 'Enter your message)'
                      ),
                    )
                  ],
                ),
              ),
              24.heightBox
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => Padding(
        padding: const EdgeInsets.all(10.0),
        child: isLoading.isTrue ? progressIndicator() : proceedButton('Book an appointment', () {
          if (_formKey.currentState!.validate()) {
            print(inputControllers['message']!.text);
            return showDialog(
              context: context,
              builder: (BuildContext context) {
              return AlertDialog(
                title: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Confirm Booking",
                    style: TextStyle(
                      color: blueTheme,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                alignment: Alignment.center,
                content: Container(
                  padding: const EdgeInsets.all(8),
                  height: 64,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Date",
                              style: TextStyle(
                                color: blueTheme,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              )
                          ),
                          Text(
                              inputControllers['date']!.text,
                              style: TextStyle(
                                color: blueTheme,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              )
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Time",
                              style: TextStyle(
                                color: blueTheme,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              )
                          ),
                          Text(
                              inputControllers['appointmentTime']!.text,
                              style: TextStyle(
                                color: blueTheme,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  proceedButton('Book Now', () async {
                    setState(() {
                      isConnecting = true;
                    });
                    String? response = await AppointmentService().saveAppointment(AppointmentModel(
                      doctor: widget.doctor.email!, patient: FirebaseAuth.instance.currentUser!.email!,
                      phone: inputControllers['phone']!.text, date: inputControllers['date']!.text,
                      time: inputControllers['appointmentTime']!.text,
                      message: inputControllers['message']!.text
                    ));
                    print(response);
                    setState(() {
                      isConnecting = false;
                    });
                    if (response!.isEmpty) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => BookingSuccess())
                      );
                    }
                    else {
                      toast(response);
                      return;
                    }
                  }, isConnecting: isConnecting)
                ],
              );
            }
            );
          }
          else {
            toast('Check the form before submitting!');
            return null;
          }
        }),
      ))
    );
  }
}
