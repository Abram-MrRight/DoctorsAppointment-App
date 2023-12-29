import 'package:doctors_appt/consts/lists.dart';
import 'package:doctors_appt/controllers/auth_controller.dart';
import 'package:doctors_appt/controllers/userController/userController.dart';
import 'package:doctors_appt/views/login_view/login.dart';
import 'package:doctors_appt/views/login_view/login_view.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../controllers/settings_controller.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(title: AppStrings.settings, color: AppColors.whiteColor),

      ),
      body: Obx(
              () => controller.isLoading.value
                  ? Center(
                child: CircularProgressIndicator(),
              )
          :Column(
          children: [
            ListTile(
              leading: CircleAvatar(child: Image.asset(Appassets.imgSignup)),
              title: AppStyles.bold(title: controller.username.value),
              subtitle: AppStyles.normal(title:controller.email.value),
            ),
            const Divider(),
            18.heightBox,
            ListView(
              shrinkWrap: true,
              children:List.generate(
                  settingsList.length,
                      (index) => ListTile(
                        onTap: (){
                          if (index == 2){
                            AuthController().signOut();
                            Get.offAll(() => const LoginView());
                          }
                        },
                        leading: Icon(
                          settingsListIcon[index],
                          color: AppColors.blueColor,
                        ),
                title: AppStyles.bold(
                  title: settingsList[index],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
