import 'package:doctors_appt/consts/lists.dart';
import 'package:doctors_appt/controllers/home_controller.dart';
import 'package:doctors_appt/views/category_details/category_details.dart';
import 'package:doctors_appt/views/search_view/search_entry_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../consts/consts.dart';
import 'package:get/get.dart';

import '../doctor_profile/doctor_profile_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    // placeholder data to test the doctor cards
    late dynamic docData;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.account_circle_sharp
          ),
          onPressed: () {
            // open drawer
            VxToast.show(context, msg: 'Drawer open');
          },
        ),
        title: AppStyles.bold(
          title: "Welcome ${FirebaseAuth.instance.currentUser?.email}",
          size: AppSizes.size18.toDouble(),
          color: AppColors.whiteColor,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search
            ),
            onPressed: () {
              Get.to(() => const SearchEntryView());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  40.heightBox,
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                              Get.to(() => Category_details(catName: iconsTitleList[index]));
                          },
                          child: Container(
                            width: 72,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: AppColors.blueTheme,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(right: 8),
                            child: Column(
                              children: [
                                Image.asset(
                                  iconsList[index],
                                  width: 30,
                                ),
                                5.heightBox,
                                AppStyles.normal(title: iconsTitleList[index], color: AppColors.whiteColor),
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                  20.heightBox,
                  const HorizontalAdvertCardList(),
                  10.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Popular Doctors",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.blueTheme,
                      )
                    ),
                  ),
                  10.heightBox,

                  FutureBuilder(
                      future: controller.getDoctorList(),
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                        if(!snapshot.hasData){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var data = snapshot.data?.docs;
                          // to be deleted later
                          docData = data;
                          return SizedBox(
                            height: 200,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: data?.length ?? 0,
                                itemBuilder: (BuildContext context, int index){
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)
                                    ),
                                    margin: const EdgeInsets.all(8.0),
                                    color: AppColors.blueTheme,
                                    child: SizedBox(
                                      width: 140,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                ClipRRect(
                                                  borderRadius: const BorderRadius.only(
                                                    topLeft: Radius.circular(16),
                                                    topRight: Radius.circular(16)
                                                  ),
                                                  child: Image.asset(
                                                    Appassets.imgSignup,
                                                    height: double.infinity, // Adjust the height of the image
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(
                                                    child: IconButton(
                                                      icon: const Icon(
                                                        Icons.favorite_outline,
                                                        color: Colors.red,
                                                        size: 24.0,
                                                      ),
                                                      onPressed: () {
                                                        VxToast.show(
                                                          context,
                                                          msg: 'Added to Favorites',
                                                          textColor: Colors.white,
                                                          bgColor: AppColors.blueTheme,
                                                          position: VxToastPosition.center
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(() => DoctorProfile(doc: data[index]));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data![index]['fullname'],
                                                    style: const TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4.0),
                                                  Text(
                                                    data![index]['docCategory'],
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.white
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          );
                        }
                      }
                  ),
                  10.heightBox,
                  GestureDetector(
                    onTap: (){},
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: AppStyles.bold(
                        title: "View All",
                        color: AppColors.blueTheme,
                        size: AppSizes.size14.toDouble()
                      ),
                    ),
                  ),
                  10.heightBox,
                  GestureDetector(
                    onTap: () {
                      Get.to(
                          () => DoctorProfile(doc: docData[0])
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 156,
                      padding: const EdgeInsets.all(8),
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
                                    const Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Dr. Anisha Patil',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            'Catrgory',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            '8128 Gloss Rd',
                                            style: TextStyle(
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
                                  const Text(
                                    '4.5',
                                    style: TextStyle(
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
                  ),
                  10.heightBox,
                  GestureDetector(
                    onTap: () {
                      Get.to(
                              () => DoctorProfile(doc: docData[0])
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 156,
                      padding: const EdgeInsets.all(8),
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
                                      const Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Dr. Anisha Patil',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Catrgory',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '8128 Gloss Rd',
                                              style: TextStyle(
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
                                  const Text(
                                    '4.5',
                                    style: TextStyle(
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
                  ),
                  10.heightBox,
                  GestureDetector(
                    onTap: () {
                      Get.to(
                              () => DoctorProfile(doc: docData[0])
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 156,
                      padding: const EdgeInsets.all(8),
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
                                      const Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Dr. Anisha Patil',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Catrgory',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '8128 Gloss Rd',
                                              style: TextStyle(
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
                                  const Text(
                                    '4.5',
                                    style: TextStyle(
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
                  ),
                  10.heightBox,
                  GestureDetector(
                    onTap: () {
                      Get.to(
                              () => DoctorProfile(doc: docData[0])
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 156,
                      padding: const EdgeInsets.all(8),
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
                                      const Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Dr. Anisha Patil',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Catrgory',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '8128 Gloss Rd',
                                              style: TextStyle(
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
                                  const Text(
                                    '4.5',
                                    style: TextStyle(
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
                  ),
                  10.heightBox,
                  GestureDetector(
                    onTap: () {
                      Get.to(
                              () => DoctorProfile(doc: docData[0])
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 156,
                      padding: const EdgeInsets.all(8),
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
                                      const Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Dr. Anisha Patil',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Catrgory',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '8128 Gloss Rd',
                                              style: TextStyle(
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
                                  const Text(
                                    '4.5',
                                    style: TextStyle(
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
                  ),
                  10.heightBox,
                  GestureDetector(
                    onTap: () {
                      Get.to(
                              () => DoctorProfile(doc: docData[0])
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 156,
                      padding: const EdgeInsets.all(8),
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
                                      const Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Dr. Anisha Patil',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Catrgory',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '8128 Gloss Rd',
                                              style: TextStyle(
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
                                  const Text(
                                    '4.5',
                                    style: TextStyle(
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
                  ),
                  10.heightBox,
                  GestureDetector(
                    onTap: () {
                      Get.to(
                              () => DoctorProfile(doc: docData[0])
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 156,
                      padding: const EdgeInsets.all(8),
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
                                      const Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Dr. Anisha Patil',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Catrgory',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '8128 Gloss Rd',
                                              style: TextStyle(
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
                                  const Text(
                                    '4.5',
                                    style: TextStyle(
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
                  ),
                  10.heightBox,
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

class AdvertCard extends StatelessWidget {
  final String? imageUrl;
  final String? imageAsset;
  final String url;

  const AdvertCard({super.key, required this.url, this.imageAsset, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchURL(Uri.parse(url));
      },
      child: Container(
        width: 256.0, // Adjust the width as needed
        margin: const EdgeInsets.all(8.0),
        decoration: imageUrl != null ? BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage(imageUrl!),
            fit: BoxFit.cover,
          ),
        ) : null,
        child: imageAsset != null ?
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            imageAsset!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ) :
        const Center(
          child: Text(
            'Your Advert Content',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class HorizontalAdvertCardList extends StatelessWidget {
  const HorizontalAdvertCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0, // Adjust the height as needed
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          AdvertCard(url: '', imageUrl: 'https://miro.medium.com/v2/resize:fit:828/format:webp/0*wyD07LhN9BXLtoGl'),
          AdvertCard(url: '', imageUrl: 'https://miro.medium.com/v2/resize:fit:828/format:webp/0*BUoDCSwYNKROMgWU'),
          AdvertCard(url: '', imageUrl: 'https://miro.medium.com/v2/resize:fit:828/format:webp/0*yRW7z7HYpj5yezkO'),
          // Add more AdvertCard widgets as needed
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const CustomCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        VxToast.show(context, msg: 'Hey hop');
      },
      child: Card(
        margin: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.network(
                    imageUrl,
                    height: 150.0, // Adjust the height of the image
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      child: Icon(
                        Icons.favorite_outline,
                        color: Colors.red,
                        size: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}