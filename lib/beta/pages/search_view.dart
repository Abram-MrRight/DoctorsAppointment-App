import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/widgets.dart';
import '../constants/colors.dart';

class SearchView extends StatelessWidget {
  final searchQuery;
  SearchView({super.key, this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: text('Search Results', size: 18, color: light),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('users').where('isDoctor', isEqualTo: true).get(),
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
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(right: 8),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            color: blueTheme,
                            child: Image.asset(
                              noImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          5.heightBox,
                          text(doc['docName']),
                          VxRating(
                            selectionColor: Colors.deepOrangeAccent,
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
