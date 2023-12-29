import 'package:doctors_appt/consts/lists.dart';
import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/views/category_details/category_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CategoryView extends StatelessWidget {


  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(title: AppStrings.category, size: AppSizes.size18.toDouble(), color: AppColors.whiteColor)
      ),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
            gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          mainAxisExtent: 200,
        ),
          itemCount: iconsList.length,
          itemBuilder : (BuildContext context, int index){
          return GestureDetector(
            onTap: (){
              Get.to(() =>  Category_details(catName: iconsTitleList[index]));
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                    color: AppColors.blueColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      iconsList[index],
                      width: 60,

                    ),
                  ),

                  20.heightBox,
                  AppStyles.bold(
                      title: iconsTitleList[index],
                      color: AppColors.whiteColor,
                      size: AppSizes.size16.toDouble()
                  ),
                  10.heightBox,
                  AppStyles.normal(
                      title: "13 specialists",
                      color: AppColors.whiteColor.withOpacity(0.5),
                      size: AppSizes.size14.toDouble()
                  )
                ],
              ),
            ),
          );
          }
        ),
      ),
    );
  }
}
