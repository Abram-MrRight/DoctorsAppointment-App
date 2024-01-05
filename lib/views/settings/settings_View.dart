import 'package:doctors_appt/views/profile/profile_view.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../controllers/settings_controller.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SettingsController());
    return Scaffold(
      drawer: const ProfileView(),
      appBar: AppBar(
        elevation: 0.0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.account_circle_sharp),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: AppStyles.bold(
          title: AppStrings.settings,
          size: AppSizes.size18.toDouble(),
          color: AppColors.whiteColor
        ),
      ),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(
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
                      padding: const EdgeInsets.all(12),
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