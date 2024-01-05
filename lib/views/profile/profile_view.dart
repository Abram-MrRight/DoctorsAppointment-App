import 'package:doctors_appt/views/profile/password_changing_view.dart';
import 'package:doctors_appt/views/profile/profile_editing_view.dart';
import 'package:get/get.dart';
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
              Navigator.of(context).pop();
              Get.to(
                  () => const ProfileEditingView()
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.password, color: AppColors.blueTheme),
            title: Text(
              "Change Password",
              style: TextStyle(
                  color: AppColors.blueTheme,
                  fontWeight: FontWeight.w900
              )
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PasswordChangeView())
              );
            },
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
            //  Get.to(()=> MyPaymentPage());

            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Sign Out"),
            onTap: () async{
              // Show confirmation dialog
              await Get.defaultDialog(
                title: "Do you want to logout?",
                titleStyle: TextStyle(
                  color: AppColors.blueTheme,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                contentPadding: const EdgeInsets.all(16),
                content: Container(),
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.blueTheme)
                    ),
                    child: Text(
                      "No",
                      style: TextStyle(
                        color: AppColors.blueTheme
                      ),
                    )
                  ),
                  OutlinedButton(
                      onPressed: () {
                        AuthController().signOut();
                        Get.offAll(() => const LoginView());
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.blueTheme,
                        foregroundColor: AppColors.whiteColor
                      ),
                      child: const Text("Yes")
                  )
                ],
              );
            }

    )
        ],
      ),
    );
  }
}
