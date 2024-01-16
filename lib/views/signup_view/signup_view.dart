import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/consts/lists.dart';
import 'package:doctors_appt/controllers/auth_controller.dart';
import 'package:doctors_appt/res/components/custom_button.dart';
import 'package:doctors_appt/res/components/custom_textfield.dart';
import 'package:doctors_appt/res/components/widgets.dart';
import 'package:get/get.dart';
import '../login_view/login_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  var isDoctor = false, isConnecting = false;
  final _formKey = GlobalKey<FormState>();

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
            AppStyles.bold(
                title: AppStrings.signupNow,
                size: AppSizes.size18.toDouble(),
                textStyle: const TextStyle(color: Colors.white),
                alignment: TextAlign.center
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
                        hint: AppStrings.fullName,
                        textController: controller.fullNameController
                      ),
                      10.heightBox,
                      CustomTextField(
                        hint: AppStrings.email,
                        textController: controller.emailController
                      ),
                      10.heightBox,
                      CustomTextField(
                        hint: AppStrings.password,
                        textController: controller.passwordController
                      ),
                      10.heightBox,
                      CustomTextField(
                        hint: "Confirm Password",
                        textController: controller.confirmPassword,
                        refTextController: controller.passwordController,
                      ),
                      20.heightBox,
                      Visibility(
                        visible: isDoctor,
                        child: Column(
                          children: [
                            CustomTextField(
                              hint: "About",
                              textController: controller.aboutController
                            ),
                            10.heightBox,
                            CustomTextField(
                              hint: "Address",
                              textController: controller.addressController
                            ),
                            10.heightBox,
                            DropdownButtonFormField(
                              onChanged: (value) {
                                controller.categoryController = value ?? '';
                              },
                              items: specialists
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, overflow: TextOverflow.ellipsis),
                                );
                              }).toList(),
                              hint: const Text("Category", style: TextStyle(color: Colors.black),),
                              decoration: const InputDecoration(
                                isDense: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black
                                    )
                                ),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                border:  OutlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                                hintText: "Category",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            10.heightBox,
                            CustomTextField(
                              hint: "Phone Number",
                              textController: controller.phoneController
                            ),
                            10.heightBox,
                            CustomTextField(
                              hint: "Services",
                              textController: controller.serviceController
                            ),
                            10.heightBox,
                            CustomTextField(
                              hint: "Timing",
                              textController: controller.timingController
                            ),
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
                      authButton(context, AppStrings.signup, isConnecting, () async{
                          if (!_formKey.currentState!.validate()) {
                            VxToast.show(
                                context,
                                msg: "Invalid input! Check your entries and try again.",
                                bgColor: const Color(0xFF1055E5),
                                textColor: Colors.white,
                                textSize: 16
                            );
                          }
                          else {
                            setState(() {
                              isConnecting = true;
                            });
                            String response = await controller.signupUser(isDoctor);
                            setState(() {
                              isConnecting = false;
                            });
                            if(response.isEmpty){
                              Get.offAll(() => const LoginView());
                            }
                            // if(controller.userCredential !=null){
                            //   Get.offAll(() => const LoginView());
                            // }
                            else {
                              toast(response);
                            }
                          }
                        }
                      ),
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
}
