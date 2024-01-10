import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appt/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../views/doctor_profile/doctor_profile_view.dart';

Widget progressIndicator () {
  return const CircularProgressIndicator(
    color: Colors.white,
    backgroundColor: Colors.blue,
  );
}

Widget authButton (BuildContext context, String buttonText, bool condition, Function()? onTap) {
  return SizedBox(
    width: context.screenWidth,
    height: 44,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: const Color(0xFF1055E5),
          foregroundColor: Colors.white,
        ),
        onPressed: onTap,
        child: condition ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [progressIndicator(), 16.widthBox, buttonText.text.make()],
        ) : buttonText.text.make()
    ),
  );
}

void toast(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: AppColors.blueTheme,
    textColor: Colors.white,
    gravity: ToastGravity.CENTER
  );
}

Future<Map<String, dynamic>?> getUser() async {
  try {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    print('');
    return userDocument.data();
  } on FirebaseException catch(error) {
    print('FirebaseException');
    return {};
  }
}

Widget futureWidget() {
  return FutureBuilder<Map<String, dynamic>?>(
    future: getUser(),
    builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
      if (snapshot.hasError || !snapshot.hasData) {
        print('error or no data..................');
        snapshot.error.printError();
        return Text('${snapshot.error}');
      }
      else if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active) {
        print('loadin..................');
        return progressIndicator();
      }
      else {
        Map<String, dynamic>? doctors = snapshot!.data;
        return SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var doctor = doctors![index];
              return GestureDetector(
                onTap: () {
                  Get.to(
                          () => DoctorProfile(doc: doctor)
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 156,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ]
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 36,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(36),
                                      child: Image.asset(
                                          Appassets.imLogin
                                      ),
                                    ),
                                  ),
                                  20.widthBox,
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${doctor?['fullname']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          '${doctor?['docCategory']}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          '${doctor?['docAddress']}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {

                                  },
                                  icon: const Icon(
                                    Icons.favorite_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ]
                        ),
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Rating',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                              4.widthBox,
                              Text(
                                '${doctor?['docRating']}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Consultation Fees',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                              4.widthBox,
                              const Text(
                                'UGX 4,000',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Experience',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                              4.widthBox,
                              const Text(
                                '14 years',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    },
  );
}