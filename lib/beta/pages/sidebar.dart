import '../constants/colors.dart';
import '../constants/strings.dart';
import '../pages/login_page.dart';
import '../pages/password_change_page.dart';
import '../pages/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/widgets.dart';
import '../models/users.dart';

class Sidebar extends StatelessWidget {
  UserModel? user;
  Sidebar({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    blueTheme,
                    Colors.pinkAccent
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
              ),
            ),
            child: futureDrawerAccount()
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: blueTheme,
            ),
            title: const Text(
              "Profile",
              style: TextStyle(
                  color: blueTheme,
                  fontWeight: FontWeight.w900
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.password, color: blueTheme),
            title: const Text(
                "Change Password",
                style: TextStyle(
                    color: blueTheme,
                    fontWeight: FontWeight.w900
                )
            ),
            onTap: () {
              navigateTo(context, const PasswordChangePage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: blueTheme),
            title: const Text(
                "Settings",
                style: TextStyle(
                    color: blueTheme,
                    fontWeight: FontWeight.w900
                )
            ),
            onTap: () {
              navigateTo(context, const SettingsPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_online_outlined, color: blueTheme,),
            title: const Text("Medical records", style: TextStyle(
                color: blueTheme,
                fontWeight: FontWeight.w900
            )),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.payments_outlined, color: blueTheme,),
            title: const Text("Payment", style: TextStyle(
                color: blueTheme,
                fontWeight: FontWeight.w900
            )),
            onTap: (){
              //  Get.to(()=> MyPaymentPage());

            },
          ),
          ListTile(
              leading: const Icon(Icons.logout, color: danger),
              title: text('Sign Out', color: danger, weight: FontWeight.w900),
              onTap: () async {
                // Show confirmation dialog
                await showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Do you want to logout?"),
                    titleTextStyle: const TextStyle(
                        color: blueTheme,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: blueTheme)
                            ),
                            child: const Text(
                              "No",
                              style: TextStyle(
                                  color: blueTheme
                              ),
                            )
                        ),
                        OutlinedButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              navigateTo(context, LoginPage());
                            },
                            style: OutlinedButton.styleFrom(
                                backgroundColor: blueTheme,
                                foregroundColor: light
                            ),
                            child: const Text("Yes")
                        ),
                      ],
                    ),
                  );
                });
              }

          )
        ],
      ),
    );
  }
}
