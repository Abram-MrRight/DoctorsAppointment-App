import 'dart:io';
import 'package:doctors_appt/consts/fonts.dart';
import 'package:doctors_appt/controllers/settings_controller.dart';
import 'package:doctors_appt/controllers/userController/userController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';
import '../../consts/colors.dart';
import '../../consts/images.dart';

class ProfileEditingView extends StatefulWidget {
  const ProfileEditingView({super.key});

  @override
  State<ProfileEditingView> createState() => _ProfileEditingViewState();
}

class _ProfileEditingViewState extends State<ProfileEditingView> {
  var controller = Get.put(SettingsController());
  var authController = Get.put(UserController());
  bool editing = false;
  bool isDoctor = true;
  final _formKey = GlobalKey<FormState>();
  Map<String, TextEditingController> editControllers = {
    'name': TextEditingController(),
    'email': TextEditingController(),
    'phone': TextEditingController(),
    'location': TextEditingController(),
    'bio': TextEditingController(),
    'address': TextEditingController(),
    'category': TextEditingController(),
    'services': TextEditingController(),
    'opening': TextEditingController(),
    'closing': TextEditingController(),
    'allergies': TextEditingController(),
    'blood': TextEditingController(),
    'dob': TextEditingController(),
  };
  Map<String, FocusNode> focusNodes = {
    'name': FocusNode(),
    'email': FocusNode(),
    'phone': FocusNode(),
    'location': FocusNode(),
    'bio': FocusNode(),
    'address': FocusNode(),
    'category': FocusNode(),
    'services': FocusNode(),
    'opening': FocusNode(),
    'closing': FocusNode(),
    'allergies': FocusNode(),
    'blood': FocusNode(),
    'dob': FocusNode(),
  };
  List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  File? selectedImage;
  PickedFile? pickedFile;
  late SharedPreferences _preferences;
  String? imagePath;

  @override
  void initState() {
    loadPreferences();
    super.initState();
  }

  Future<void> loadPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      imagePath = _preferences.getString('profilePhoto');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      appBar: AppBar(
        title: AppStyles.bold(
          title: controller.username.value,
          color: AppColors.whiteColor,
          size: AppSizes.size18.toDouble()
        ),
        actions: [
          TextButton(
            onPressed: () {
              // save profile changes
              VxToast.show(
                  context, msg: "Profile changes saved!", position: VxToastPosition.center,
                bgColor: AppColors.blueTheme, textColor: AppColors.whiteColor
              );
            },
            child: Text(
              "Save",
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          bottom: 48
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 24
              ),
              width: double.infinity,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 84,
                    backgroundImage: imagePath != null ? FileImage(
                      File(imagePath!),
                    ) : AssetImage(
                      Appassets.imgDefault,
                    ) as ImageProvider
                  ),
                  InkWell(
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.blueTheme,
                      size: 32,
                    ),
                    onTap: () {
                      editing = true;
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext bc) {
                            return Container(
                              color: AppColors.blueTheme,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 64
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.camera, color: AppColors.whiteColor),
                                      TextButton(
                                        onPressed: () async {
                                          _pickImage(ImageSource.camera);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Camera', style: TextStyle(color: AppColors.whiteColor, fontSize: AppSizes.size20.toDouble())),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.image_outlined, color: AppColors.whiteColor),
                                      TextButton(
                                        onPressed: () {
                                          _pickImage(ImageSource.gallery);
                                        },
                                        child: Text('Gallery', style: TextStyle(color: AppColors.whiteColor, fontSize: AppSizes.size20.toDouble())),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                      );
                    },
                  )
                ]
              ),
            ),
            10.heightBox,
            Card(
              elevation: 8,
              shadowColor: AppColors.textColor,
              margin: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 4
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextInputField('Name', controller.username.value, 1, editControllers['name']!, focusNodes['name']!),
                      const Divider(),
                      buildTextInputField('Email', controller.email.value, 1, editControllers['email']!, focusNodes['email']!,
                        validator: (value) {
                          if (!RegExp(r'\w+@\w+\.[a-zA-Z_]{2,}').hasMatch(value.toString())) {
                            return 'Invalid email format';
                          }
                          return '';
                        }
                      ),
                      const Divider(),
                      buildTextInputField('Phone Number', '123456789', 1, editControllers['phone']!, focusNodes['phone']!, keyboard: TextInputType.phone),
                      const Divider(),
                      buildTextInputField('Location', 'Kampala', 1, editControllers['location']!, focusNodes['location']!),
                      const Divider(),
                      Column(
                        children: [
                          buildTextInputField('Bio', 'Doctor bio goes here...lorem ipsum blah blah blah', 5, editControllers['bio']!, focusNodes['bio']!),
                          const Divider(),
                          buildTextInputField('Speciality', 'Categories', 1, editControllers['category']!, focusNodes['category']!),
                          const Divider(),
                          buildTextInputField('Services', 'List of services offered goes here', 5, editControllers['services']!, focusNodes['services']!),
                          const Divider(),
                          buildTextInputField('Address', 'Health facility address', 1, editControllers['address']!, focusNodes['address']!),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text('Opening Time', style: TextStyle(fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  InkWell(
                                    onTap: () => _selectTime(editControllers['opening']!),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.access_time),
                                          const SizedBox(width: 5),
                                          Text(editControllers['opening']!.text),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text('Closing Time', style: TextStyle(fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  InkWell(
                                    onTap: () => _selectTime(editControllers['closing']!),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.access_time),
                                          const SizedBox(width: 5),
                                          Text(editControllers['closing']!.text),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          8.heightBox
                        ],
                      ), // to be displayed for doctors only
                      const Divider(),
                      Column(
                        children: [
                          buildTextInputField('Allergies', 'None', 1, editControllers['allergies']!, focusNodes['allergies']!),
                          const Divider(),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: "Blood Type",
                              labelStyle: TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold),
                              border: InputBorder.none
                            ),
                            items: bloodTypes.map<DropdownMenuItem<String>>((String bloodType) {
                              return DropdownMenuItem<String>(
                                value: bloodType,
                                child: Text(bloodType),
                              );
                            }).toList(),
                            focusNode: focusNodes['blood'],
                            onChanged: (String? value) {
                              editControllers['blood']!.text = value ?? '';
                            },
                          ),
                          const Divider(),
                          const Text(
                            "Date of Birth",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          DatePickerWidget(
                            looping: true,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            dateFormat: "dd/MMMM/yyyy",
                            onChange: (DateTime newDate, _) {
                              setState(() {
                                editControllers['dob']?.text = newDate.toString();
                              });
                            },
                            pickerTheme: const DateTimePickerTheme(
                              backgroundColor: Colors.transparent,
                              itemTextStyle:
                              TextStyle(fontSize: 19),
                              dividerColor: Colors.grey,
                            ),
                          )
                        ],
                      ) // to be displayed for patients only
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextInputField(
      String label,
      String value,
      int maxLines,
      TextEditingController controller,
      FocusNode focusNode,
      { String? Function(String?)? validator,
        TextInputType? keyboard,
      }
      ) {

    return TextFormField(
      decoration: InputDecoration(
        hintText: value,
        border: InputBorder.none,
        labelText: label,
        labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textColor
        ),
      ),
      maxLines: 1,
      textAlign: TextAlign.right,
      initialValue: value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      focusNode: focusNode,
      onChanged: (value) {
        controller.text = value;
      },
      onEditingComplete: () {
        focusNode.nextFocus();
      },
      keyboardType: keyboard,
    );
  }

  Future<void> _selectTime(TextEditingController controller) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      if (!context.mounted) return;
      setState(() {
        controller.text = selectedTime.format(context);
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final returnedImage = await ImagePicker().pickImage(source: source);

    if (returnedImage != null) {
      setState(() {
        // Update the image
        // controller.profileImage.value = pickedFile.path;
        selectedImage = File(returnedImage.path);
        _preferences.setString('profilePhoto', selectedImage!.path);
      });
    }
  }
}
