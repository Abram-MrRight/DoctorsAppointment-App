import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/consts/images.dart';
import 'package:doctors_appt/consts/strings.dart';
import 'package:doctors_appt/controllers/auth_controller.dart';
import 'package:doctors_appt/res/components/custom_button.dart';
import 'package:doctors_appt/res/components/custom_textfield.dart';
import 'package:doctors_appt/views/home_view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

import '../home_view/home.dart';
import '../login_view/login_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  var isDoctor = false;

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

                      CustomTextField(hint: AppStrings.fullName, textController: controller.fullNameController,),
                      CustomTextField(hint: AppStrings.fullName, textController: controller.fullNameController,),
                      10.heightBox,
                      CustomTextField(hint: AppStrings.fullName, textController: controller.fullNameController),
                      10.heightBox,
                      CustomTextField(hint: AppStrings.email, textController: controller.emailController,),
                      10.heightBox,
                      CustomTextField(hint: AppStrings.password, textController: controller.passwordController,),
                      20.heightBox,


                      Visibility(
                        visible: isDoctor,
                        child: Column(
                          children: [
                            CustomTextField(hint: "About", textController: controller.aboutController,),
                            10.heightBox,
                            CustomTextField(hint: "Address", textController: controller.addressController,),
                            10.heightBox,
                            CustomTextField(hint: "Category", textController: controller.categoryController,),
                            10.heightBox,
                            CustomTextField(hint: "Phone Number", textController: controller.phoneController,),
                            10.heightBox,
                            CustomTextField(hint: "Rating", textController: controller.ratingController,),
                            10.heightBox,
                            CustomTextField(hint: "Services", textController: controller.serviceController,),
                            10.heightBox,
                            CustomTextField(hint: "Timing", textController: controller.timingController,),
                            10.heightBox,
                          ],
                        ),
                      ),

                      //switch button for doctor option
                      SwitchListTile(value: isDoctor, onChanged: (newValue){
                        setState(() {
                          isDoctor = newValue;
                        });
                      }, title: "Signup as a doctor".text.make(),
                      ),
                      CustomButton(
                          buttonText: AppStrings.signup,
                          onTap: () async{
                         await controller.signupUser(isDoctor);
                        if(controller.userCredential !=null){
                          Get.offAll(() => LoginView());
                        }
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
