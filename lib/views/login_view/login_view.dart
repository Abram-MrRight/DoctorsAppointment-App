import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/consts/images.dart';
import 'package:doctors_appt/consts/strings.dart';
import 'package:doctors_appt/res/components/custom_button.dart';
import 'package:doctors_appt/res/components/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(

          padding: EdgeInsets.all(8),
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

              CustomTextField(hint: AppStrings.email),
              10.heightBox,
              CustomTextField(hint: AppStrings.password),
              20.heightBox,
              Align(
                alignment: Alignment.centerRight,
                child: AppStyles.normal(title: AppStrings.forgetPassword),
              ),
              20.heightBox,
              CustomButton(buttonText: AppStrings.login, onTap: () {}),
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppStyles.normal(title: AppStrings.dontHaveAccount),
                  8.widthBox,
                  Text(
                    AppStrings.signup,
                    style: TextStyle(color: Colors.blue), // Set the text color directly here
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: LoginView()));