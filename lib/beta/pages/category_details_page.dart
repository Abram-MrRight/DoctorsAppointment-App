import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/strings.dart';
import '../models/users.dart';
import '../pages/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/widgets.dart';
import '../constants/colors.dart';

class CategoryDetailsPage extends StatelessWidget {
  String specialistType;
  CategoryDetailsPage({super.key, required this.specialistType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text(specialistType),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<List<UserModel>>(
            future: UserService().getDoctorsByCategory(specialistType),
            builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
              if (!snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                print('no data..................');
                snapshot.error.printError();
                return Center(child: text('No doctors found in this category!', size: 16, color: dark.withOpacity(0.5)));
              }
              else if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active) {
                print('loading doctors..................');
                return Center(child: progressIndicator());
              }
              else if (snapshot.hasData) {
                List<UserModel>? doctors = snapshot!.data;
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
          ),
        ),
      )
    );
  }
}
