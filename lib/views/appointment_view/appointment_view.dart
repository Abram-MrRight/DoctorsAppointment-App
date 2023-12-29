import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appt/controllers/appointment_controller.dart';
import 'package:doctors_appt/views/appointment_details_view/appointment_details_view.dart';

import '../../consts/consts.dart';
import 'package:flutter/material.dart'; // Import Material for Scaffold
import 'package:get/get.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());

    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(
          title: "Appointments",
          color: AppColors.whiteColor,
          size: AppSizes.size14.toDouble(),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: controller.getAppointments(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var data = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: data?.length ?? 0, // Use actual data length
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Get.to(() =>  AppointmentDetailsView(
                        doc: data[index],
                      ));
                    },
                    leading: CircleAvatar(
                      child: Image.asset(Appassets.imgSignup),
                    ),
                    title: AppStyles.bold(title: data[index]['appWithName']),
                    subtitle: AppStyles.normal(
                      title: "${data[index]['appDay']} - ${data[index]['appTime']}",
                      color: AppColors.textColor.withOpacity(0.5),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}