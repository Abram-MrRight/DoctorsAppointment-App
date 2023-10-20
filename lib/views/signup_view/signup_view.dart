import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/consts/images.dart';
import 'package:doctors_appt/consts/strings.dart';
import 'package:doctors_appt/res/components/custom_button.dart';
import 'package:doctors_appt/res/components/custom_textfield.dart';
import 'package:doctors_appt/views/home_view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

import '../login_view/login_view.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Appassets.imgSignup,
              width: 200,
            ),
            10.heightBox,
            AppStyles.bold(title: AppStrings.signupNow, size: AppSizes.size18.toDouble(), textStyle: TextStyle(color: Colors.white), alignment: TextAlign.center),

            //AppStrings.welcomeBack.text.make(),
            // AppStrings.weAreExcited.text.make(),
            30.heightBox,

            Expanded(
              child:Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      CustomTextField(hint: AppStrings.fullName),
                      CustomTextField(hint: AppStrings.email),
                      10.heightBox,
                      CustomTextField(hint: AppStrings.password),
                      20.heightBox,
                      CustomButton(buttonText: AppStrings.signup, onTap: () {
                        Get.to(()=> const HomeView());
                      }),
                      20.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppStyles.normal(title: AppStrings.alreadyHaveAccount),
                          8.widthBox,

                          GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: Text(
                              AppStrings.login,
                              style: TextStyle(color: Colors.blue), // Set the text color directly here
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
