import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/controllers/auth_controller.dart';
import 'package:doctors_appt/res/components/custom_button.dart';
import 'package:doctors_appt/res/components/custom_textfield.dart';
import 'package:doctors_appt/views/home_view/home.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../signup_view/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();

}

class _LoginViewState extends State<LoginView> {
  var isDoctor = false;
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    final _formKey = GlobalKey<FormState>();

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
            AppStyles.bold(
                title: AppStrings.welcomeBack,
                size: AppSizes.size18.toDouble(),
                textStyle: const TextStyle(color: Colors.white)
            ),
            AppStyles.bold(
                title: AppStrings.weAreExcited,
                textStyle: const TextStyle(color: Colors.white)
            ),

            //AppStrings.welcomeBack.text.make(),
            // AppStrings.weAreExcited.text.make(),
            30.heightBox,

            Expanded(
              child:Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                        hint: AppStrings.email,
                        textController: controller.emailController
                      ),
                      10.heightBox,
                      CustomTextField(
                        hint: AppStrings.password,
                        textController: controller.passwordController
                      ),
                      //switch button for doctor option
                      SwitchListTile(value: isDoctor, onChanged: (newValue){
                        setState(() {
                          isDoctor = newValue;
                        });
                      }, title: "Login as a doctor".text.make(),
                      ),

                      20.heightBox,

                      Align(
                        alignment: Alignment.centerRight,
                        child: AppStyles.normal(title: AppStrings.forgetPassword),
                      ),
                      20.heightBox,
                      CustomButton(
                        buttonText: AppStrings.login,
                        onTap: () async {
                          login(_formKey, controller);
                        }
                      ),
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
                              style: const TextStyle(
                                color: Color(0xFF1055E5),
                                fontWeight: FontWeight.bold
                              ), // Set the text color directly here
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

  void login(GlobalKey<FormState> formKey, AuthController controller) async {
    if (!formKey.currentState!.validate()) {
      VxToast.show(
          context,
          msg: "Invalid input! Check your entries and try again.",
          bgColor: const Color(0xFF1055E5),
          textColor: Colors.white,
          textSize: 16
      );
    }
    else {
      await controller.loginUser();
      if(controller.userCredential != null){
        final SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setBool('isDoctor', isDoctor);
        Get.to(() => Home(isDoctor: isDoctor));
      }
    }
  }
}




