import 'package:get/get.dart';

class UserController extends GetxController {
  RxString patientName = ''.obs;
  RxString patientEmail = ''.obs;

  // Function to update user details
  void updateUserDetails(String newName, String newEmail) {
    patientName.value = newName;
    patientEmail.value = newEmail;
    update(); // Ensure to call update() to trigger UI rebuild
  }
}
