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

    return  Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
          UserAccountsDrawerHeader(
              accountName: Text(controller.username.value),
              accountEmail: Text(controller.email.value),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child: Image.asset(Appassets.imgWelcome),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              image: DecorationImage(image:AssetImage(Appassets.ic_splash),
              fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text("Upload shot"),
            onTap: () => print("upload tapped"),
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text("Change Password"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.book_online_outlined),
            title: Text("Medical records"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.payments_outlined),
            title: Text("Payment"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("SignOut"),
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