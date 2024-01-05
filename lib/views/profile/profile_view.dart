import 'package:doctors_appt/views/payment_view/payment_form.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/settings_controller.dart';
import '../login_view/login_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SettingsController());

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
          UserAccountsDrawerHeader(
              accountName: Text(
                controller.username.value,
                style: const TextStyle(
                  fontWeight: FontWeight.w900
                ),
              ),
              accountEmail: Text(controller.email.value),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                Appassets.imgWelcome
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.blueTheme,
                  Colors.pinkAccent
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
              ),
              image: DecorationImage(image:AssetImage(Appassets.ic_splash),
              fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: AppColors.blueTheme,
            ),
            title: Text(
              "Profile",
              style: TextStyle(
                color: AppColors.blueTheme,
                fontWeight: FontWeight.w900
              ),
            ),
            onTap: () {
              // Get.to(
              //     () => const ProfileEditingView()
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.password),
            title: const Text("Change Password"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.book_online_outlined),
            title: const Text("Medical records"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.payments_outlined),
            title: const Text("Payment"),
            onTap: (){
              Get.to(()=>const PaymentForm());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("SignOut"),
            onTap: () {
              AuthController().signOut();
              Get.offAll(() => const LoginView());
            }
    )
        ],
      ),
    );
  }
}
