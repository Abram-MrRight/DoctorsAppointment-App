import 'dart:io';

import '../components/signup_page_views.dart';
import '../components/widgets.dart';
import '../constants/compound_data.dart';
import '../constants/strings.dart';
import '../models/users.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../utilities/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isConnecting = false;
  bool _isDoctor = false;
  UserModel user = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 64),
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    logo,
                    height: 100,
                  )
                ),
                const SizedBox(height: 64),
                // Full Name TextField
                TextFormField(
                  controller: inputControllers['fullName'],
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    icon: Icon(Icons.person),
                  ),
                  onEditingComplete: () =>
                      FocusScope.of(context).nextFocus(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Username TextField
                TextFormField(
                  controller: inputControllers['username'],
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    icon: Icon(Icons.account_circle),
                  ),
                  onEditingComplete: () =>
                      FocusScope.of(context).nextFocus(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Email TextField
                TextFormField(
                  controller: inputControllers['email'],
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                  ),
                  onEditingComplete: () =>
                      FocusScope.of(context).nextFocus(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Phone TextField
                TextFormField(
                  controller: inputControllers['phone'],
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    icon: Icon(Icons.phone),
                  ),
                  onEditingComplete: () =>
                      FocusScope.of(context).nextFocus(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Password TextField
                TextFormField(
                  controller: inputControllers['password'],
                  textInputAction: TextInputAction.next,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    icon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  onEditingComplete: () =>
                      FocusScope.of(context).nextFocus(),
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Confirm Password TextField
                TextFormField(
                  controller: inputControllers['confirmPassword'],
                  textInputAction: TextInputAction.done,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    icon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword =
                          !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value != inputControllers['password']!.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Sign Up Button
                _isConnecting
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      user = user.copyWith(
                        fullName: inputControllers['fullName']!.text,
                        username: inputControllers['username']!.text,
                        email: inputControllers['email']!.text,
                        phone: inputControllers['phone']!.text,
                        password: inputControllers['password']!.text,
                      );
                      setState(() {
                        _isConnecting = true;
                      });
                      User? userInstance = await UserService().signUp(user);
                      setState(() {
                        _isConnecting = false;
                        user = user.copyWith(id: userInstance!.uid);
                      });
                      if (userInstance != null) {
                        _showSignUpDialog();
                      } else {
                        Util.toast('Sign up failed!');
                        return;
                      }
                    }
                  },
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 10),
                // Already have an account? Login button
                TextButton(
                  onPressed: () {
                    // Navigate to the login page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: const Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showSignUpDialog() async {
    final prefs = await SharedPreferences.getInstance();
    if (!context.mounted) return;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Signing Up as:'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isDoctor = false;
                    prefs.setBool('isDoctor', _isDoctor);
                    // User selected Patient
                  });
                  Navigator.of(context).pop();
                  showSetupPageView();
                },
                child: const Text('Patient'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isDoctor = true; // User selected Doctor
                    prefs.setBool('isDoctor', _isDoctor);
                  });
                  Navigator.of(context).pop();
                  showSetupPageView();
                },
                child: const Text('Doctor'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showSetupPageView() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: PageView(
              controller: _pageController,
              children: _buildPageViews(),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildPageViews() {
    if (_isDoctor == true) {
      return [
        // Doctor - Location, Facility Name, Speciality, Profile Photo Upload
        _buildDoctorPage1(),
        _buildDoctorPage2(),
        _buildDoctorPage3(),
        _buildDoctorPage4(),
        _buildDoctorPage5(),
        _buildDoctorPage6(),
        _buildDoctorPage7(),
        _buildDoctorPage8(),
        _buildDoctorPage9(),
      ];
    } else {
      return [
        // Patient - Location, Allergies, Blood Type, Date of Birth, Profile Photo Upload
        _buildPatientPage1(),
        _buildPatientPage2(),
        _buildPatientPage3(),
        _buildPatientPage4(),
        _buildPatientPage5(),
      ];
    }
  }

  Widget _buildDoctorPage1() {
    return SignUpPageView(
      labelText: 'City Location',
      description: 'Almost there!\nLet\'s finish setting up your account',
      textController: inputControllers['location'],
      onEditingComplete: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      isLastPage: false,
      onSkipPressed: () {
        // Handle Skip button pressed
      },
      onNextPressed: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      onFinishPressed: null,
    );
  }

  Widget _buildDoctorPage2() {
    return SignUpPageView(
      labelText: 'Work Place',
      description: 'Where can patients find you?\nMention your work address!',
      textController: inputControllers['address'],
      onEditingComplete: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      isLastPage: false,
      onSkipPressed: () {
        // Handle Skip button pressed
      },
      onNextPressed: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      onFinishPressed: null,
    );
  }

  Widget _buildDoctorPage3() {
    return SignUpPageView(
      labelText: 'Speciality',
      description: 'Let\'s narrow it down!\nWhat do you specialize at?',
      dropdownData: specialistTypes,
      textController: inputControllers['speciality'],
      onEditingComplete: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      isLastPage: false,
      onSkipPressed: () {
        // Handle Skip button pressed
        _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      onNextPressed: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      onFinishPressed: null,
    );
  }

  Widget _buildDoctorPage4() {
    return SignUpPageView(
      labelText: 'Services',
      description: 'What other services does your facility offer?',
      textController: inputControllers['services'],
      onEditingComplete: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      isLastPage: false,
      onSkipPressed: () {
        // Handle Skip button pressed
        _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      onNextPressed: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      onFinishPressed: null,
    );
  }

  Widget _buildDoctorPage5() {
    return SignUpPageView(
      labelText: 'Experience',
      description: 'How long have you been in your medical field?',
      textController: inputControllers['experience'],
      onEditingComplete: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      isLastPage: false,
      onSkipPressed: () {
        // Handle Skip button pressed
        _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      onNextPressed: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      onFinishPressed: null,
    );
  }

  Widget _buildDoctorPage6() {
    return SignUpPageView(
      labelText: 'Consultation Fee',
      description: 'How much are your consultations?',
      textController: inputControllers['consultationFee'],
      onEditingComplete: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      isLastPage: false,
      onSkipPressed: () {
        // Handle Skip button pressed
        _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      onNextPressed: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      onFinishPressed: null,
    );
  }

  Widget _buildDoctorPage7() {
    return SignUpPageView(
      labelText: 'Working Days',
      description: 'Provide us with your schedule to manage your appointments!',
      customDatePicker: SizedBox(
        height: 253,
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return ListView.builder(
              itemCount: workingDays.length,
              itemBuilder: (context, index) {
                return CheckboxMenuButton(
                  onChanged: (bool? value) {
                    setState(() {
                      workingDays[workingDays.keysList()[index]] = value!;
                    });
                  },
                  value: workingDays[workingDays.keysList()[index]],
                  child: Text(workingDays.keysList()[index]),
                );
              },
            );
          },
        ),
      ),
      onEditingComplete: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      isLastPage: false,
      onSkipPressed: () {
        // Handle Skip button pressed
        _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      onNextPressed: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      onFinishPressed: null,
    );
  }

  Widget _buildDoctorPage8() {
    var punchIn = '8:00 AM', punchOut = '5:00 PM';
    return StatefulBuilder(
      builder: (context, StateSetter setState) {
      return SignUpPageView(
        labelText: 'Daily Schedule',
        description: 'What times do you punch in and out at the office?',
        customDatePicker: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: Text(punchIn),
              onPressed: () async {
                await _selectTime(inputControllers['punchIn']!, 8);
                setState(() {
                  punchIn = inputControllers['punchIn']!.text;
                });
              },
            ),
            const Text('to'),
            TextButton(
              child: Text(punchOut),
              onPressed: () async {
                await _selectTime(inputControllers['punchOut']!, 17);
                setState(() {
                  punchOut = inputControllers['punchOut']!.text;
                });
              },
            ),
          ],
        ),
        onEditingComplete: () {
          // Move to the next page
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        isLastPage: false,
        onSkipPressed: () {
          // Handle Skip button pressed
          _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        },
        onNextPressed: () {
          // Move to the next page
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        onFinishPressed: null,
      );}
    );
  }

  Widget _buildDoctorPage9() {
    bool isConnecting = false;
    return StatefulBuilder(
      builder: (context, StateSetter setState) {
      return SignUpPageView(
        labelText: 'Profile Photo',
        description: 'Upload your profile photo.\n This is optional, you can just skip it!',
        isLastPage: true,
        onUploadPressed: () async {
          // Prompt user to pick an image from gallery
          PickedFile? pickedFile = (await ImagePicker().pickImage(
            source: ImageSource.gallery,
          )) as PickedFile?;

          if (pickedFile != null) {
          // Handle the picked file, you can save it or display it as needed
          inputControllers['profilePhoto']!.text = pickedFile.path;
          File imageFile = File(pickedFile.path);
          // You can now use the imageFile as needed
          }
        },
        onFinishPressed: () async {
          setState(() {
            isConnecting = true;
          });
          String response = await UserService().updateUser(user.copyWith(
            days: workingDays,
            services: inputControllers['services']!.text,
            speciality: inputControllers['speciality']!.text,
            address: inputControllers['address']!.text,
            profilePhoto: inputControllers['profilePhoto']!.text,
            location: inputControllers['location']!.text,
            isDoctor: true,
            consultationFee: inputControllers['consultationFee']!.text,
            experience: inputControllers['experience']!.text,
            punchIn: inputControllers['punchIn']!.text,
            punchOut: inputControllers['punchOut']!.text
          ));
          setState(() {
            isConnecting = false;
          });
          if (response.isEmpty) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage())
            );
          }
          else {
            toast(response);
            return;
          }
        },
      );}
    );
  }

  Widget _buildPatientPage1() {
    return SignUpPageView(
      labelText: 'City Location',
      description: 'Almost there!\nLet\'s finish setting up your account',
      textController: inputControllers['location'],
      onEditingComplete: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      isLastPage: false,
      onSkipPressed: () {
        // Handle Skip button pressed
        _pageController.animateToPage(5, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      onNextPressed: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      onFinishPressed: null,
    );
  }

  Widget _buildPatientPage2() {
    return SignUpPageView(
      labelText: 'Allergies',
      description: 'Got any allergies? Mention them.\nOr just proceed to the next page',
      textController: inputControllers['allergies'],
      onEditingComplete: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      isLastPage: false,
      onSkipPressed: () {
        // Handle Skip button pressed
      },
      onNextPressed: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      onFinishPressed: null,
    );
  }

  Widget _buildPatientPage3() {
    return SignUpPageView(
      labelText: 'Blood Type',
      description: 'Select your blood type.\nYou don\'t know? It\'s OK. Let\'s Continue',
      dropdownData: bloodTypes,
      textController: inputControllers['bloodType'],
      onEditingComplete: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      isLastPage: false,
      onSkipPressed: () {
        // Handle Skip button pressed
      },
      onNextPressed: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      onFinishPressed: null,
    );
  }

  Widget _buildPatientPage4() {
    return SignUpPageView(
      labelText: 'Date of Birth',
      description: 'Select your date of birth\nKnowing your age facilitates our doctors in their diagnoses',
      customDatePicker: DatePickerWidget(
        looping: true,
        firstDate: DateTime(1900),
        lastDate: DateTime.now().subtract(const Duration(days: 365*13)),
        dateFormat: "dd-MMMM-yyyy",
        onChange: (DateTime newDate, _) {
          setState(() {
            inputControllers['date']?.text = newDate.toString().substring(0, 10);
          });
        },
        pickerTheme: const DateTimePickerTheme(
          backgroundColor: Colors.transparent,
          itemTextStyle: TextStyle(fontSize: 19),
          dividerColor: Colors.grey,
        ),
      ),
      isLastPage: false,
      onSkipPressed: () {
        // Handle Skip button pressed
      },
      onNextPressed: () {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      onFinishPressed: null,
    );
  }

  Widget _buildPatientPage5() {
    bool isConnecting = false;
    return SignUpPageView(
      labelText: 'Profile Photo',
      description: 'Upload your profile photo.\n This is optional, you can just skip it!',
      isLastPage: true,
      onUploadPressed: () async {
        // Handle Skip button pressed
        // Prompt user to pick an image from gallery
        PickedFile? pickedFile = (await ImagePicker().pickImage(
          source: ImageSource.gallery,
        )) as PickedFile?;

        if (pickedFile != null) {
        // Handle the picked file, you can save it or display it as needed
        inputControllers['profilePhoto']!.text = pickedFile.path;
        File imageFile = File(pickedFile.path);
        // You can now use the imageFile as needed
        }
      },
      onFinishPressed: () async {
        setState(() {
          isConnecting = true;
        });
        String response = await UserService().updateUser(user.copyWith(
          profilePhoto: inputControllers['profilePhoto']!.text,
          location: inputControllers['location']!.text,
          isDoctor: false,
          bloodType: inputControllers['bloodType']!.text,
          allergies: inputControllers['allergies']!.text,
          dob: inputControllers['date']!.text
        ));
        setState(() {
          isConnecting = false;
        });
        if (response.isEmpty) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage())
          );
        }
        else {
          toast(response);
          return;
        }
      },
    );
  }

  Future<void> _selectTime(TextEditingController controller, int hour) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: 0),
    );

    if (selectedTime != null) {
      if (!context.mounted) return;
      setState(() {
        controller.text = selectedTime.format(context);
      });
    }
  }
}
