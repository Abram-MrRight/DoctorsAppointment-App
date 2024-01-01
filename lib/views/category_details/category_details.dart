import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appt/views/doctor_profile/doctor_profile_view.dart';

import '../../consts/consts.dart';
import 'package:get/get.dart';

class Category_details extends StatelessWidget {
  String catName;

   Category_details({super.key, required this.catName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(title: catName, color: AppColors.whiteColor, size: AppSizes.size14.toDouble()),
      ),
      body:FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('doctors').where('docCategory', isEqualTo:catName ).get(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
    if(!snapshot.hasData){
    return const Center(
    child: CircularProgressIndicator(),
    );
    }else{
      var data = snapshot.data?.docs;
      return  Padding(
      padding: const EdgeInsets.all(10.0),
    child: GridView.builder(
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisExtent: 170, crossAxisSpacing: 8, mainAxisSpacing: 8,
    ),
    itemCount: data?.length ?? 0,
    itemBuilder: (BuildContext context, int index){
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
    AppStyles.normal(title: data![index]['fullname']),
    VxRating(
    selectionColor: AppColors.yellowColor,
    onRatingUpdate: (value){},
    maxRating: 5,
    count: 5,
    value: double.parse(data[index]['docRating'].toString()),
    stepInt: true,
    ),


    ],
    ),
    ).onTap(() {
      Get.to(() => DoctorProfile(doc: data[index]));
    });
    },

    ),
    );
    }
    }
    )
    );
  }
}
