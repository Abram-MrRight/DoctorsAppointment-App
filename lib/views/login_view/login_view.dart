import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/consts/images.dart';
import 'package:doctors_appt/consts/strings.dart';
import 'package:doctors_appt/controllers/auth_controller.dart';
import 'package:doctors_appt/res/components/custom_button.dart';
import 'package:doctors_appt/res/components/custom_textfield.dart';
import 'package:doctors_appt/views/home_view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

import '../signup_view/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key});

  @override
  State<LoginView> createState() => _LoginViewState();

}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());


    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Appassets.imLogin,
              width: 200,
            ),
            10.heightBox,
            AppStyles.bold(title: AppStrings.welcomeBack, size: AppSizes.size18.toDouble(), textStyle: TextStyle(color: Colors.white)),
            AppStyles.bold(title: AppStrings.weAreExcited, textStyle:TextStyle(color: Colors.white)),

            //AppStrings.welcomeBack.text.make(),
            // AppStrings.weAreExcited.text.make(),
            30.heightBox,

            Expanded(
              child:Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(hint: AppStrings.email, textController: controller.emailController,),
                      10.heightBox,
                      CustomTextField(hint: AppStrings.password, textController: controller.passwordController,),
                      20.heightBox,
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppStyles.normal(title: AppStrings.forgetPassword),
                      ),
                      20.heightBox,
                      CustomButton(
                          buttonText: AppStrings.login,

                          onTap: () async{
                           await controller.loginUser();
                           if(controller.userCredential != null){
                             Get.to(() => const Home());
                           }
                      }),
                      20.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppStyles.normal(title: AppStrings.dontHaveAccount),
                          8.widthBox,

                          GestureDetector(
                            onTap: (){
                              Get.to(()=>const SignupView());
                            },
                            child: Text(
                              AppStrings.signup,
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




