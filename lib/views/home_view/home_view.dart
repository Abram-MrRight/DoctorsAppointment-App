import 'package:doctors_appt/consts/lists.dart';
import 'package:doctors_appt/controllers/home_controller.dart';
import 'package:doctors_appt/res/components/custom_textfield.dart';
import 'package:doctors_appt/views/category_details/category_details.dart';
import 'package:doctors_appt/views/search_view/search_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../consts/consts.dart';
import 'package:get/get.dart';

import '../doctor_profile/doctor_profile_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    return Scaffold(
        appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(
        title: "Welcome ${FirebaseAuth.instance.currentUser?.email}",
        size: AppSizes.size18.toDouble(),
    color: AppColors.whiteColor,
    ),
        ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(14),
              color: AppColors.blueColor,
              child: Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                        hint: AppStrings.search,
                          borderColor: AppColors.whiteColor,
                        textColor: AppColors.whiteColor,
                      ),
                  ),
                  10.widthBox,
                  IconButton(
                      onPressed: (){
                        Get.to(() => SearchView(
                          searchQuery: controller.searchQueryController.text,
                        ));
                      },
                      icon: Icon(
                        Icons.search,
                        color: AppColors.whiteColor,
                      ),
                  ),
                ],
              ),
            ),
            20.heightBox,
            Padding(
                padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                          onTap: (){
                            Get.to(() => Category_details(catName: iconsTitleList[index]));
                          },
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: AppColors.blueColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(right: 8),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppStyles.bold(title: "Popular Doctors", color: AppColors.blueColor),
                  ),
                  10.heightBox,

                  FutureBuilder(
                      future: controller.getDoctorList(),
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                        if(!snapshot.hasData){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }else{
                          var data = snapshot.data?.docs;
                          return  SizedBox(
                            height: 150,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: data?.length ?? 0,
                                itemBuilder: (BuildContext context, int index){
                                  return GestureDetector(
                                    onTap: (){
                                      Get.to(() =>  DoctorProfile(doc: data[index]));
                                    },
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          color: AppColors.bgDarkColor,
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      margin: EdgeInsets.only(right: 8),
                                      height: 100,
                                      width: 150,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 150,
                                            alignment: Alignment.center,
                                            color: AppColors.blueColor,
                                            child: Image.asset(
                                              Appassets.imgSignup,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          5.heightBox,
                                          AppStyles.bold(title: data![index]['docName']),
                                          AppStyles.normal(title: data![index]['docCategory']),
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

                  5.heightBox,
                  GestureDetector(
                    onTap: (){},
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: AppStyles.normal(title: "view All", color: AppColors.blueColor),

                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        4,
                            (index) => Container(
                              padding: EdgeInsets.all(12),
                              color: AppColors.blueColor,
                              child: Column(
                                children: [
                                  Image.asset(Appassets.ic_body, width: 25, color: AppColors.whiteColor,),
                                  5.heightBox,
                                  AppStyles.normal(title: "Lab Test", color: AppColors.whiteColor),
                                ],
                              ),
                            ))
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
