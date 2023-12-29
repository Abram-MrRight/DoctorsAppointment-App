import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appt/views/doctor_profile/doctor_profile_view.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';

class SearchView extends StatelessWidget {
  final searchQuery;
   SearchView({super.key, this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(
        title: "Search Results",
        size: AppSizes.size18.toDouble(),
    color: AppColors.whiteColor,
      ),
    ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('doctors').get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else{
              var doc = snapshot.data!.docs!;
              return  Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 170, crossAxisSpacing: 8, mainAxisSpacing: 8,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index){
                    var doc = snapshot.data!.docs[index];

                    /*
                       !(doc['docName'].toString().toLowerCase()).contains(searchQuery)
                      ? const
                    SizedBox.shrink()
                      :GestureDetector(
                      onTap: (){
                        Get.to(() => DoctorProfile(doc: doc));
                      },*/
                    return  Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColors.bgDarkColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.only(right: 8),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              color:AppColors.blueColor,
                              child: Image.asset(
                                Appassets.imgSignup,
                                fit: BoxFit.cover,
                              ),
                            ),
                            5.heightBox,
                            AppStyles.normal(title:doc['docName']),
                            VxRating(
                              selectionColor: AppColors.yellowColor,
                              onRatingUpdate: (value){},
                              maxRating: 5,
                              count: 5,
                              value: double.parse(doc['docRating'].toString()),
                              stepInt: true,
                            ),


                          ],
                        ),
                    );

                  },

                ),
              );
            }
          }
      ),
    );
  }
}
