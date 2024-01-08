import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appt/res/components/custom_button.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../consts/consts.dart';
import '../book_appointment/book_appointment.dart';

class DoctorProfile extends StatefulWidget {
  final DocumentSnapshot doc;
   const DoctorProfile({super.key, required this.doc});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  bool viewMoreReviews = false;

  @override
  Widget build(BuildContext context) {
    var rating = double.parse(widget.doc['docRating'].toString());

    return  Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      appBar: AppBar(
        title: AppStyles.bold(
            title: widget.doc['fullname'],
            color: AppColors.whiteColor
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              height: 256,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.blueTheme,
                    const Color(0xFF0171ff)
                  ],
                  begin: AlignmentDirectional.bottomCenter,
                  end: AlignmentDirectional.topCenter
                ),
                borderRadius: const BorderRadius.only(
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
                          Appassets.imgSignup
                        ),
                      ),
                      16.widthBox,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppStyles.bold(
                                title: widget.doc['fullname'],
                                color: AppColors.whiteColor,
                                size: AppSizes.size16.toDouble()
                            ),
                            4.heightBox,
                            AppStyles.bold(
                                title: widget.doc['docCategory'],
                                color: AppColors.whiteColor.withOpacity(0.5),
                                size: AppSizes.size12.toDouble()
                            ),
                            4.heightBox,
                            AppStyles.bold(
                                title: widget.doc['docAddress'],
                                color: AppColors.whiteColor,
                                size: AppSizes.size16.toDouble()
                            ),
                            4.heightBox,
                            VxRating(
                              selectionColor: AppColors.yellowColor,
                              onRatingUpdate: (value){
                                setState(() {
                                  rating = double.parse(value);
                                });
                              },
                              maxRating: 5,
                              count: 5,
                              value: double.parse(widget.doc['docRating'].toString()),
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
                          CircleAvatar(
                            child: Icon(
                              Icons.person_add_alt_1_outlined,
                              color: AppColors.blueTheme,
                            ),
                          ),
                          8.widthBox,
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '254+',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                              Text(
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
                          CircleAvatar(
                            child: Icon(
                              Icons.star_rate_outlined,
                              color: AppColors.blueTheme,
                            ),
                          ),
                          8.widthBox,
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '8 Years',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                              Text(
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
                          CircleAvatar(
                            child: Icon(
                              Icons.reviews_outlined,
                              color: AppColors.blueTheme,
                            ),
                          ),
                          8.widthBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$rating",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                              const Text(
                                'Reviews',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white
                                ),
                              )
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          child: Icon(
                            Icons.attach_money_outlined,
                            color: AppColors.blueTheme,
                          ),
                        ),
                        const Text(
                          "Consultation Fee",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                        const Text(
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
                      color: AppColors.whiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: AppStyles.bold(
                              title: "Phone Number",
                              color: AppColors.textColor
                          ),
                          subtitle: AppStyles.normal(title: widget.doc['docPhone'].toString(), color: AppColors.textColor.withOpacity(0.5), size: AppSizes.size14.toDouble()),
                          trailing: Container(
                            width: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.yellowColor,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                launchUrl(
                                    Uri.parse("tel:+123456789")
                                );
                              },
                              child: const Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                            )
                          ),
                        ),
                        10.heightBox,
                        AppStyles.bold(title: "About", color: AppColors.textColor, size: AppSizes.size16.toDouble()),
                        5.heightBox,
                        AppStyles.normal(
                          title: widget.doc['docAbout'],
                          color: AppColors.textColor.withOpacity(0.5),
                          size: AppSizes.size12.toDouble(),
                        ),
                        10.heightBox,
                        AppStyles.bold(title: "Services", color: AppColors.textColor, size: AppSizes.size16.toDouble()),
                        5.heightBox,
                        AppStyles.normal(title: widget.doc['docService'], color: AppColors.textColor.withOpacity(0.5), size: AppSizes.size12.toDouble()),
                        10.heightBox,
                        AppStyles.bold(title: "Working Time", color: AppColors.textColor, size: AppSizes.size16.toDouble()),
                        5.heightBox,
                        AppStyles.normal(title:widget.doc['docTiming'], color: AppColors.textColor.withOpacity(0.5), size: AppSizes.size12.toDouble()),
                        10.heightBox,
                      ],
                    ),
                  ),
                  10.heightBox,
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "Patient Reviews",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.blueTheme
                      ),
                    ),
                  ),
                  10.heightBox,
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                      Appassets.imLogin
                                    ),
                                  ),
                                  const SizedBox(width: 16,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'David Park',
                                          style: TextStyle(
                                            color: AppColors.blueTheme,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        VxRating(
                                          selectionColor: AppColors.yellowColor,
                                          onRatingUpdate: (value){
                                            setState(() {
                                              rating = double.parse(value);
                                            });
                                          },
                                          maxRating: 5,
                                          count: 5,
                                          value: double.parse(widget.doc['docRating'].toString()),
                                          stepInt: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              8.heightBox,
                              const Text(
                                'Visited for toothache!',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              8.heightBox,
                              const Text(
                                'Lorem ipsum dolor sit amet, consecutoer adisnfs  eleit.' +
                                    'Etiam efficurie ipsum in placetrat molestie. Fsusckmek',

                              ),
                              8.heightBox,
                              Text(
                                'December 28, 2023',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(.5),
                                  fontSize: 12
                                ),
                              ),
                            ],
                          ),
                        ),
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
                            color: Colors.white,
                            child: Row(
                              children: [
                                Text(
                                  'More Reviews',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppColors.blueTheme
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
                        viewMoreReviews ? Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                color: Colors.grey[300],
                                thickness: 2,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                        Appassets.imLogin
                                    ),
                                  ),
                                  const SizedBox(width: 16,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'David Park',
                                          style: TextStyle(
                                              color: AppColors.blueTheme,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        VxRating(
                                          selectionColor: AppColors.yellowColor,
                                          onRatingUpdate: (value){
                                            setState(() {
                                              rating = double.parse(value);
                                            });
                                          },
                                          maxRating: 5,
                                          count: 5,
                                          value: double.parse(widget.doc['docRating'].toString()),
                                          stepInt: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              8.heightBox,
                              const Text(
                                'Visited for toothache!',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              8.heightBox,
                              const Text(
                                'Lorem ipsum dolor sit amet, consecutoer adisnfs  eleit.' +
                                    'Etiam efficurie ipsum in placetrat molestie. Fsusckmek',

                              ),
                              8.heightBox,
                              Text(
                                'December 28, 2023',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.5),
                                    fontSize: 12
                                ),
                              ),
                              InkWell(
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
                                  child: Row(
                                    children: [
                                      Text(
                                        'Less Reviews',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: AppColors.blueTheme
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.expand_less,
                                        color: Colors.grey[500],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ) : Container(),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.blueTheme
                            )
                          ),
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => const ReviewDialog()
                              );
                            },
                            child: Text(
                              'Share Your Review',
                              style: TextStyle(
                                color: AppColors.blueTheme
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomButton(buttonText: "Book an appointment",
          onTap: (){
          Get.to(() =>  BookAppointment(docId: widget.doc['docId'],fullname: widget.doc['fullname'],
          ));

        },),
      ),
    );

  }
}

class ReviewDialog extends StatefulWidget {
  const ReviewDialog({super.key});
  @override
  State<StatefulWidget> createState() => _MyCustomDialog();
}

class _MyCustomDialog extends State<ReviewDialog> {
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Material(
              color: AppColors.blueTheme,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16)
              ),
              child: Container(
                height: 50,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white,),
                      onPressed: () {
                        rating = 0;
                        Navigator.of(context).pop();
                      },
                    ),
                    const Text(
                      'New Review',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      splashColor: AppColors.blueTheme,
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
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: AppColors.blueTheme,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            rating = 1;
                          });
                        },
                        icon: Icon(
                            rating >= 1 ? Icons.star :
                            Icons.star_border_outlined,
                          color: AppColors.blueTheme
                        )
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              rating = 2;
                            });
                          },
                          icon: Icon(
                              rating >= 2 ? Icons.star :
                              Icons.star_border_outlined,
                              color: AppColors.blueTheme
                          )
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              rating = 3;
                            });
                          },
                          icon: Icon(
                              rating >= 3 ? Icons.star :
                              Icons.star_border_outlined,
                              color: AppColors.blueTheme
                          )
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              rating = 4;
                            });
                          },
                          icon: Icon(
                              rating >= 4 ? Icons.star :
                              Icons.star_border_outlined,
                              color: AppColors.blueTheme
                          )
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              rating = 5;
                            });
                          },
                          icon: Icon(
                              rating >= 5 ? Icons.star :
                              Icons.star_border_outlined,
                              color: AppColors.blueTheme
                          )
                      ),
                    ],
                  ),
                  24.heightBox,
                  const TextField(
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                    maxLength: 32,
                    decoration: InputDecoration(
                        hintText: 'Review Title',
                        hintStyle: TextStyle(
                            color: Colors.black26
                        )
                    ),
                  ),
                  8.heightBox,
                  const TextField(
                    style: TextStyle(

                    ),
                    maxLines: 10,
                    maxLength: 500,
                    decoration: InputDecoration(
                        hintText: 'Describe your experience (optional)',
                        hintStyle: TextStyle(
                            color: Colors.black26
                        )
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
