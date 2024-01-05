import 'package:doctors_appt/controllers/myAppointment_controller.dart';
import 'package:doctors_appt/res/components/custom_textfield.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../consts/consts.dart';
import '../../res/components/custom_button.dart';
import 'package:get/get.dart';

import 'booking_success_view.dart';

class BookAppointment extends StatelessWidget {
  final String docId;
  final String fullname;
  const BookAppointment({super.key, required this.docId, required this.fullname});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MyAppointmentController());
    var _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      appBar: AppBar(
        title: AppStyles.bold(title: fullname, color: AppColors.whiteColor, size: AppSizes.size14.toDouble()),
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
                        Appassets.imgSignup
                    ),
                  ),
                  4.heightBox,
                  AppStyles.bold(
                      title: fullname,
                      color: AppColors.textColor,
                      size: AppSizes.size16.toDouble()
                  ),
                  4.heightBox,
                  AppStyles.bold(
                      title: 'general',
                      color: AppColors.textColor.withOpacity(0.5),
                      size: AppSizes.size12.toDouble()
                  ),
                  4.heightBox,
                  AppStyles.bold(
                      title: "UGX 4,000",
                      color: AppColors.textColor,
                      size: AppSizes.size16.toDouble()
                  ),
                ],
              ),
            ),
            10.heightBox,
            MyCalendar(controller: controller),
            10.heightBox,
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Time Slots",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            4.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    controller.appointmentTimeController.text = "08:00 AM";
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          // Pressed state
                          return Colors.blue;
                        } else if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.grey;
                        }
                        // Default state
                        return Colors.white;
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.white;
                        }
                        // Default state
                        return Colors.black;
                      },
                    ),
                  ),
                  child: const Text("08:00 AM"),
                ),
                OutlinedButton(
                  onPressed: () {
                    controller.appointmentTimeController.text = "09:00 AM";
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          // Pressed state
                          return Colors.blue;
                        } else if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.grey;
                        }
                        // Default state
                        return Colors.white;
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.white;
                        }
                        // Default state
                        return Colors.black;
                      },
                    ),
                  ),
                  child: const Text("09:00 AM"),
                ),
                OutlinedButton(
                  onPressed: () {
                    controller.appointmentTimeController.text = "10:00 AM";
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          // Pressed state
                          return Colors.blue;
                        } else if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.grey;
                        }
                        // Default state
                        return Colors.white;
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.white;
                        }
                        // Default state
                        return Colors.black;
                      },
                    ),
                  ),
                  child: const Text("10:00 AM"),
                ),
              ],
            ),
            4.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    controller.appointmentTimeController.text = "12:00 PM";
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          // Pressed state
                          return Colors.blue;
                        } else if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.grey;
                        }
                        // Default state
                        return Colors.white;
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.white;
                        }
                        // Default state
                        return Colors.black;
                      },
                    ),
                  ),
                  child: const Text("12:00 PM"),
                ),
                OutlinedButton(
                  onPressed: () {
                    controller.appointmentTimeController.text = "01:00 PM";
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          // Pressed state
                          return Colors.blue;
                        } else if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.grey;
                        }
                        // Default state
                        return Colors.white;
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.white;
                        }
                        // Default state
                        return Colors.black;
                      },
                    ),
                  ),
                  child: const Text("01:00 PM"),
                ),
                OutlinedButton(
                  onPressed: () {
                    controller.appointmentTimeController.text = "02:00 PM";
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          // Pressed state
                          return Colors.blue;
                        } else if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.grey;
                        }
                        // Default state
                        return Colors.white;
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.white;
                        }
                        // Default state
                        return Colors.black;
                      },
                    ),
                  ),
                  child: const Text("02:00 PM"),
                ),
              ],
            ),
            4.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    controller.appointmentTimeController.text = "04:00 PM";
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          // Pressed state
                          return Colors.blue;
                        } else if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.grey;
                        }
                        // Default state
                        return Colors.white;
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.white;
                        }
                        // Default state
                        return Colors.black;
                      },
                    ),
                  ),
                  child: const Text("03:00 PM"),
                ),
                OutlinedButton(
                  onPressed: () {
                    controller.appointmentTimeController.text = "04:00 PM";
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          // Pressed state
                          return Colors.blue;
                        } else if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.grey;
                        }
                        // Default state
                        return Colors.white;
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.white;
                        }
                        // Default state
                        return Colors.black;
                      },
                    ),
                  ),
                  child: const Text("04:00 PM"),
                ),
                OutlinedButton(
                  onPressed: () {
                    controller.appointmentTimeController.text = "05:00 PM";
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          // Pressed state
                          return Colors.blue;
                        } else if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.grey;
                        }
                        // Default state
                        return Colors.white;
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          // Disabled state
                          return Colors.white;
                        }
                        // Default state
                        return Colors.black;
                      },
                    ),
                  ),
                  child: const Text("05:00 PM"),
                ),
              ],
            ),
            10.heightBox,
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStyles.bold(title: "Mobile Number:"),
                  5.heightBox,
                  CustomTextField(hint: "Phone Number", textController: controller.appointmentMobileController,),
                  10.heightBox,
                  AppStyles.bold(title: "Message"),
                  5.heightBox,
                  CustomTextField(hint: "Enter your message (Optional)",
                    textController: controller.appointmentMessageController,)
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
        child: controller.isLoading.value
            ? const Center(
            child: CircularProgressIndicator())
            : CustomButton(
          buttonText: "Book an appointment",
          onTap: () async {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Confirm Booking",
                        style: TextStyle(
                          color: AppColors.blueTheme,
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
                                  color: AppColors.blueTheme,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                )
                              ),
                              Text(
                                  controller.appointmentDayController.text,
                                  style: TextStyle(
                                    color: AppColors.blueTheme,
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
                                    color: AppColors.blueTheme,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  )
                              ),
                              Text(
                                  controller.appointmentTimeController.text,
                                  style: TextStyle(
                                    color: AppColors.blueTheme,
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
                      CustomButton(
                        buttonText: "Book Now",
                        onTap: () async {
                          await controller.bookAppointment(context, docId );
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => BookingSuccess(controller: controller))
                          );
                        },
                      )
                    ],
                  );
                }
            );
          },
        ),
      )),


    );
  }
}

class MyCalendar extends StatefulWidget {
  final MyAppointmentController controller;

  const MyCalendar({
    super.key,
    required this.controller
  });

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    widget.controller.appointmentDayController.text = _selectedDay.toString().substring(0, 10);
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2024, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          widget.controller.appointmentDayController.text = _selectedDay.toString().substring(0, 10);
          _focusedDay = focusedDay;
        });
      },
      headerStyle: HeaderStyle(
        formatButtonVisible: true, // Hide the format button
        titleCentered: true,
        formatButtonTextStyle: const TextStyle().copyWith(color: Colors.white),
        formatButtonDecoration: BoxDecoration(
          color: AppColors.blueTheme,
          borderRadius: BorderRadius.circular(16.0),
        ),
        formatButtonShowsNext: true,
        titleTextStyle: const TextStyle(fontSize: 18.0),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: AppColors.blueColor.withOpacity(.5),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: AppColors.blueTheme,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}