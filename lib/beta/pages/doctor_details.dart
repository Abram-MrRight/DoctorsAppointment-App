import '../constants/colors.dart';
import '../constants/compound_data.dart';
import '../constants/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/widgets.dart';
import '../models/reviews.dart';
import '../models/users.dart';
import 'book_appointment_page.dart';

class DoctorDetail extends StatefulWidget {
  final UserModel doctor;
  DoctorDetail({super.key, required this.doctor});

  @override
  State<DoctorDetail> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorDetail> {
  bool viewMoreReviews = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: text(widget.doctor.fullName!, weight: FontWeight.bold, color: light)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              height: 256,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      blueTheme,
                      Color(0xFF0171ff)
                    ],
                    begin: AlignmentDirectional.bottomCenter,
                    end: AlignmentDirectional.topCenter
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)
                ),
              ),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius :40,
                        backgroundImage: AssetImage(
                            noImage
                        ),
                      ),
                      16.widthBox,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text(widget.doctor.fullName!, color: light, size: 16.0),
                            4.heightBox,
                            text(widget.doctor.speciality!, color: light.withOpacity(0.5), size: 12.0),
                            4.heightBox,
                            text(widget.doctor.address!, color: light, size: 16.0),
                            4.heightBox,
                            VxRating(
                              selectionColor: warning,
                              onRatingUpdate: (value){
                                setState(() {
                                  
                                });
                              },
                              maxRating: 5,
                              count: 5,
                              value: double.parse(widget.doctor.rating!),
                              stepInt: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  8.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            child: Icon(
                              Icons.person_add_alt_1_outlined,
                              color: blueTheme,
                            ),
                            backgroundColor: light,
                          ),
                          8.widthBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              futureTotalPatients(widget.doctor),
                              const Text(
                                'Patients',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const CircleAvatar(
                            child: Icon(
                              Icons.star_rate_outlined,
                              color: blueTheme,
                            ),
                            backgroundColor: light,
                          ),
                          8.widthBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text(widget.doctor.experience!, size: 16.0, weight: FontWeight.bold, color: light),
                              const Text(
                                'Experience',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const CircleAvatar(
                            child: Icon(
                              Icons.reviews_outlined,
                              color: blueTheme,
                            ),
                            backgroundColor: light,
                          ),
                          8.widthBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              futureTotalReviews(widget.doctor),
                              text('Reviews', size: 12.0, weight: FontWeight.bold, color: light),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white
                        ),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          child: Icon(
                            Icons.attach_money_outlined,
                            color: blueTheme,
                          ),
                          backgroundColor: light,
                        ),
                        Text(
                          "Consultation Fee",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                        Text(
                          'UGX 4,000',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: light,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: text('Phone Number', weight: FontWeight.bold, color: dark),
                          subtitle: text(widget.doctor.phone!, size: 14.0, weight: FontWeight.bold, color: dark.withOpacity(0.5)),
                          trailing: GestureDetector(
                            onTap: () {
                              launchUrl(
                                  Uri.parse(widget.doctor.phone!)
                              );
                            },
                            child: Container(
                                width: 40,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: warning,
                                ),
                                child: const Icon(
                                  Icons.phone,
                                  color: light,
                                )
                            ),
                          ),
                        ),
                        10.heightBox,
                        text('Services', size: 16.0, weight: FontWeight.bold, color: dark),
                        5.heightBox,
                        text(widget.doctor.services ?? 'N/A', size: 12.0, weight: FontWeight.bold, color: dark),
                        10.heightBox,
                        text('Working Days', size: 16.0, weight: FontWeight.bold, color: dark),
                        5.heightBox,
                        SizedBox(
                          height: 128,
                          child: ListView.builder(
                            itemCount: widget.doctor.days!.length,
                            itemBuilder: (context, index) {
                              Map<String, bool> week = widget.doctor!.days as Map<String, bool>;
                              List<String> days = week.keysList();
                              if (week[days[index]] == true) {
                                return Text(days[index]);
                              } else {
                                // Return an empty container for days set to false
                                return Container();
                              }
                            },
                          ),
                        ),
                        10.heightBox,
                        text('Daily Schedule', color: dark, weight: FontWeight.bold, size: 16.0),
                        5.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            text(widget.doctor.punchIn!, color: dark, size:14),
                            5.widthBox,
                            text('to', color: dark, size:14),
                            5.widthBox,
                            text(widget.doctor.punchOut!, color: dark, size:14),
                          ],
                        ),
                        10.heightBox,
                      ],
                    ),
                  ),
                  10.heightBox,
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        futureReviews(!viewMoreReviews),
                                        !viewMoreReviews ? InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (viewMoreReviews) {
                                                viewMoreReviews = false;
                                              }
                                              else {
                                                viewMoreReviews = true;
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            color: light,
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'More Reviews',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                      color: blueTheme
                                                  ),
                                                ),
                                                const Spacer(),
                                                Icon(
                                                  Icons.expand_more,
                                                  color: Colors.grey[500],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ) : Container(),
                                        viewMoreReviews ? futureReviews(viewMoreReviews) : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: blueTheme),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => ReviewDialog(doctor: widget.doctor),
                                          );
                                        },
                                        child: const Text(
                                          'Share Your Review',
                                          style: TextStyle(color: blueTheme),
                                        ),
                                      ),
                                    ),
                                    5.heightBox,
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: blueTheme),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Close the bottom sheet
                                        },
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(color: blueTheme),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: text(
                      'View Patient Reviews',
                      color: blueTheme,
                      size: 16,
                      weight: FontWeight.bold,
                      style: FontStyle.italic,
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: light,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: proceedButton('Book an appointment', () => {
          navigateTo(context, BookAppointment(doctor: widget.doctor))
        })
      ),
    );
  }

  Widget futureReviews(bool viewMoreReviews) {
    return FutureBuilder<List<ReviewModel>>(
      future: ReviewService().getReviewsForDoctor(widget.doctor.email!),
      builder: (context, AsyncSnapshot<List<ReviewModel>> snapshot) {
        if (!snapshot.hasData) {
          print('no data..................');
          snapshot.error.printError();
          return text('N/A', color: light);
        }
        else if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.active) {
          print('loading reviews..................');
          return Center(child: progressIndicator());
        }
        else if (snapshot.hasData) {
          List<ReviewModel>? allReviews, limitedReviews;
          if (viewMoreReviews) {
            limitedReviews = snapshot.data!.take(2).toList();
          } else {
            allReviews = snapshot!.data;
          }
          return viewMoreReviews ? SizedBox(
            height: allReviews!.length * 180,
            child: Column(
              children: [
                ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var review = allReviews![index];
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    noImage
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.patientName,
                                      style: TextStyle(
                                          color: blueTheme,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    VxRating(
                                      selectionColor: warning,
                                      onRatingUpdate: (value) {},
                                      maxRating: 5,
                                      count: 5,
                                      value: double.parse(review.rating.toString()),
                                      stepInt: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          8.heightBox,
                          text(review.title!, color: dark, weight: FontWeight.bold),
                          8.heightBox,
                          text(review.message!),
                          8.heightBox,
                          text(review.submitDate!, color: dark.withOpacity(0.5), size: 12),
                        ],
                      ),
                    );
                  },
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      viewMoreReviews = !viewMoreReviews;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: light,
                    child: Row(
                      children: [
                        const Text(
                          'Less Reviews',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: blueTheme
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.expand_more,
                          color: Colors.grey[500],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ) :
          SizedBox(
              height: limitedReviews!.length * 180,
              child: !viewMoreReviews ? Column(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var review = limitedReviews![index];
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      noImage
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        review.patientName,
                                        style: TextStyle(
                                            color: blueTheme,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      VxRating(
                                        selectionColor: warning,
                                        onRatingUpdate: (value) {},
                                        maxRating: 5,
                                        count: 5,
                                        value: double.parse(review.rating.toString()),
                                        stepInt: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            8.heightBox,
                            text(review.title!, color: dark, weight: FontWeight.bold),
                            8.heightBox,
                            text(review.message!),
                            8.heightBox,
                            text(review.submitDate!, color: dark.withOpacity(0.5), size: 12),
                          ],
                        ),
                      );
                    },
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        viewMoreReviews = !viewMoreReviews;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: light,
                      child: Row(
                        children: [
                          const Text(
                            'More Reviews',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: blueTheme
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.expand_more,
                            color: Colors.grey[500],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ) : Column(
                children: [

                ],
              )
          );
        }
        else {
          return Center(child: text('An unknown error occurred!'));
        }
      },
    );
  }
}

class ReviewDialog extends StatefulWidget {
  UserModel doctor;
  ReviewDialog({super.key, required this.doctor});
  @override
  State<StatefulWidget> createState() => _MyCustomDialog();
}

class _MyCustomDialog extends State<ReviewDialog> {
  int rating = 0;
  final _formKey = GlobalKey<FormState>();
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height / 2 - 20,
      left: MediaQuery.of(context).size.width / 2 - 20,
      child: progressIndicator(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Material(
              color: blueTheme,
              child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: light),
                      onPressed: () {
                        rating = 0;
                        Navigator.of(context).pop();
                      },
                    ),
                    text('New Review', color: light, weight: FontWeight.bold, size: 16),
                    InkWell(
                      splashColor: blueTheme,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                              color: blueTheme,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (!_formKey.currentState!.validate()) {
                          toast('Check your entry fields and try again');
                          return;
                        }
                        String? response = await ReviewService().saveReview(ReviewModel(
                          doctorId: widget.doctor.email!,
                          patientName: FirebaseAuth.instance.currentUser!.email!,
                          rating: int.parse(inputControllers['rating']!.text),
                          title: inputControllers['title']!.text,
                          message: inputControllers['message']!.text,
                          submitDate: DateFormat('yyyy-MM-dd').format(DateTime.now())
                        ));
                        if (response.isEmptyOrNull) {
                          toast('Review submitted!');
                          Navigator.of(context).pop();
                        }
                        else {
                          toast(response!);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  VxRating(
                    selectionColor: warning,
                    onRatingUpdate: (value){
                      setState(() {
                        inputControllers['rating']!.text = double.parse(value).round().toString();
                        print(inputControllers['rating']!.text);
                      });
                    },
                    maxRating: 5,
                    count: 5,
                    value: 0,
                    size: 36,
                    stepInt: true,
                  ),
                  24.heightBox,
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: inputControllers['title'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmptyOrNull) {
                              return 'Your first impression cannot be empty!';
                            }
                          },
                          maxLines: 1,
                          maxLength: 64,
                          decoration: InputDecoration(
                              hintText: 'Review Title',
                              hintStyle: TextStyle(
                                  color: Colors.black26
                              )
                          ),
                        ),
                        8.heightBox,
                        TextField(
                          controller: inputControllers['message'],
                          maxLines: 10,
                          maxLength: 500,
                          decoration: InputDecoration(
                              hintText: 'Describe your experience (optional)',
                              hintStyle: TextStyle(
                                  color: Colors.black26
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  8.heightBox
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
