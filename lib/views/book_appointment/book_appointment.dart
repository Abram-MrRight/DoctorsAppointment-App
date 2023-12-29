import 'package:doctors_appt/res/components/custom_textfield.dart';

import '../../consts/consts.dart';
import '../../controllers/appointment_controller.dart';
import '../../res/components/custom_button.dart';
import 'package:get/get.dart';

class BookAppointment extends StatelessWidget {
  final String docID;
  final String docName;
  const BookAppointment({super.key, required this.docID, required this.docName});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());

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
             CustomTextField(hint: "Select day",textController: controller.appDayController,),

            10.heightBox,
            AppStyles.bold(title: "Select appointment time"),
            5.heightBox,
             CustomTextField(hint: "Select time", textController: controller.appTimeController,),
            20.heightBox,
            AppStyles.bold(title: "Mobile Number:"),
            5.heightBox,
             CustomTextField(hint: "Enter your mobile number", textController: controller.appMobileController,),
            10.heightBox,
            AppStyles.bold(title: "Full Name"),
            5.heightBox,
             CustomTextField(hint: "Enter your name", textController: controller.appNameController,),
            10.heightBox,
            AppStyles.bold(title: "Message"),
            5.heightBox,
             CustomTextField(hint: "Enter your message", textController: controller.appMessageController,),
          ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(()
      => Padding(
          padding: const EdgeInsets.all(10.0),
          child: controller.isLoading.value ? Center(
            child: CircularProgressIndicator(),
          )
              :CustomButton(
            buttonText: "Book an appointment",
            onTap: () async{
              await controller.bookAppointment(docID,  context);
            },
          ),
        ),
      ),
    );
  }
}
