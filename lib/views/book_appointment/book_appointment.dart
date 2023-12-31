import 'package:doctors_appt/controllers/myAppointment_controller.dart';
import 'package:doctors_appt/res/components/custom_textfield.dart';

import '../../consts/consts.dart';
import '../../res/components/custom_button.dart';
import 'package:get/get.dart';

class BookAppointment extends StatelessWidget {
  final String docId;
  final String docName;
  const BookAppointment({super.key, required this.docId, required this.docName});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MyAppointmentController());

    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(title: docName, color: AppColors.whiteColor, size: AppSizes.size14.toDouble()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyles.bold(title: "Select appointment day"),
            5.heightBox,
             CustomTextField(hint: "Select day",textController: controller.appointmentDayController,),

            10.heightBox,
            AppStyles.bold(title: "Select appointment time"),
            5.heightBox,
             CustomTextField(hint: "Select time", textController: controller.appointmentTimeController,),
            20.heightBox,
            AppStyles.bold(title: "Mobile Number:"),
            5.heightBox,
             CustomTextField(hint: "Enter your mobile number", textController: controller.appointmentMobileController,),
            10.heightBox,
            AppStyles.bold(title: "Full Name"),
            5.heightBox,
             CustomTextField(hint: "Enter your name", textController: controller.appointmentNameController,),
            10.heightBox,
            AppStyles.bold(title: "Message"),
            5.heightBox,
             CustomTextField(hint: "Enter your message",
               textController: controller.appointmentMessageController,),
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
            await controller.bookAppointment(context, docId );
          },
        ),
      )),


    );
  }
}
