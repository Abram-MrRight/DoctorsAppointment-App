import 'package:doctors_appt/consts/colors.dart';
import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/controllers/myAppointment_controller.dart';
import 'package:doctors_appt/views/appointment_view/appointment_view.dart';
import 'package:flutter/material.dart';

import '../../res/components/custom_button.dart';

class BookingSuccess extends StatelessWidget {
  final MyAppointmentController controller;
  const BookingSuccess ({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 24
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xfffafcff),
              AppColors.blueTheme
            ],
            begin: AlignmentDirectional.bottomCenter,
            end: AlignmentDirectional.topCenter
          )
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: const BackButton(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF80a5f4),
                    radius: 96,
                    child: CircleAvatar(
                      backgroundColor: const Color(0xff779ff7),
                      radius: 64,
                      child: Icon(
                        Icons.check,
                        color: AppColors.blueTheme,
                        size: 96,
                      ),
                    ),
                  ),
                  32.heightBox,
                  Text(
                    "Thank you!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: AppColors.blueTheme
                    ),
                  ),
                  16.heightBox,
                  Text(
                    "Your appointment is set",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor
                    ),
                  ),
                  16.heightBox,
                  Text(
                    "For"
                        " ${controller.appointmentDayController.text}  "
                        "at ${controller.appointmentTimeController.text}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24
        ),
        child: CustomButton(
          buttonText: "Done",
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AppointmentView())
            );
          },
        ),
      )
    );
  }
}
