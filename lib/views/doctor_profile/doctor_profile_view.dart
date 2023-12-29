import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appt/res/components/custom_button.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../controllers/appointment_controller.dart';
import '../book_appointment/book_appointment.dart';

class DoctorProfile extends StatelessWidget {
  final DocumentSnapshot doc;
  const DoctorProfile({super.key, required this.doc});



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      appBar: AppBar(
        title: AppStyles.bold(title: "Doctor Details", color: AppColors.whiteColor, size: AppSizes.size12.toDouble()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  Row(
                  children: [
                    CircleAvatar(
                      radius :40,
                      child: Image.asset(
                          Appassets.imgSignup
                      ),
                    ),
                    10.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppStyles.bold(title: doc['docName'], color: AppColors.textColor, size: AppSizes.size14.toDouble()),
                          AppStyles.bold(title: doc['docCategory'], color: AppColors.textColor.withOpacity(0.5), size: AppSizes.size12.toDouble()),
                          const Spacer(),
                          VxRating(
                            selectionColor: AppColors.yellowColor,
                            onRatingUpdate: (value){},
                            maxRating: 5,
                            count: 5,
                            value: double.parse(doc['docRating'].toString()),
                            stepInt: true,
                          ),

                        ],
                      ),
                    ),
                    AppStyles.bold(title: "See all review", color: AppColors.blueColor, size: AppSizes.size12.toDouble()),

                  ],
                ),
              ),
              10.heightBox,
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: AppStyles.bold(title: "Phone Number", color: AppColors.textColor),
                      subtitle: AppStyles.normal(title: doc['docPhone'].toString(), color: AppColors.textColor.withOpacity(0.5), size: AppSizes.size14.toDouble()),
                      trailing: Container(
                        width: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.yellowColor,
                        ),
                        child: Icon(
                          Icons.phone,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    10.heightBox,
                    AppStyles.bold(title: "About", color: AppColors.textColor, size: AppSizes.size16.toDouble()),
                    5.heightBox,
                    AppStyles.normal(
                      title: doc['docAbout'],
                      color: AppColors.textColor.withOpacity(0.5),
                      size: AppSizes.size12.toDouble(),
                    ),
                    10.heightBox,
                    AppStyles.bold(title: "Address", color: AppColors.textColor, size: AppSizes.size16.toDouble()),
                    5.heightBox,
                    AppStyles.normal(title: doc['docAddress'], color: AppColors.textColor.withOpacity(0.5), size: AppSizes.size12.toDouble()),
                    10.heightBox,
                    AppStyles.bold(title: "Working Time", color: AppColors.textColor, size: AppSizes.size16.toDouble()),
                    5.heightBox,
                    AppStyles.normal(title:doc['docTiming'], color: AppColors.textColor.withOpacity(0.5), size: AppSizes.size12.toDouble()),
                    10.heightBox,
                    AppStyles.bold(title: "Services", color: AppColors.textColor, size: AppSizes.size16.toDouble()),
                    5.heightBox,
                    AppStyles.normal(title: doc['docService'], color: AppColors.textColor.withOpacity(0.5), size: AppSizes.size12.toDouble()),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomButton(buttonText: "Book an appointment", onTap: (){
          Get.to(() =>  BookAppointment(docID: doc['docID'],docName: doc['docName'],));

        },),
      ),
    );

  }
}
