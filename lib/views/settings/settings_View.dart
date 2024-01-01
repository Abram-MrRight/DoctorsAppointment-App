import 'package:doctors_appt/consts/lists.dart';
import 'package:doctors_appt/controllers/auth_controller.dart';
import 'package:doctors_appt/views/login_view/login_view.dart';
import 'package:doctors_appt/views/profile/profile_view.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../controllers/settings_controller.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SettingsController());
    return Scaffold(
      drawer: const ProfileView(),
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
            GestureDetector(
              onTap: (){},
              child: Align(
                alignment: Alignment.centerRight,
                child: AppStyles.normal(title: "view All", color: AppColors.blueColor),

              ),
            ),
            20.heightBox,
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    4,
                        (index) => Container(
                      padding: EdgeInsets.all(12),
                      color: AppColors.blueColor,
                      child: Column(
                        children: [
                          Image.asset(Appassets.ic_body, width: 25, color: AppColors.whiteColor,),
                          5.heightBox,
                          AppStyles.normal(title: "Lab Test", color: AppColors.whiteColor),
                        ],
                      ),
                    ))
            ),
          ],
        ),
      ),
    );
  }
}