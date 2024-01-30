import '../components/widgets.dart';
import '../constants/strings.dart';
import '../models/users.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({super.key});

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 230,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  GestureDetector(
                    onTap: () {print('card');},
                    child: Card(
                      margin: EdgeInsets.all(8),
                      color: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                    noImage
                                  ),
                                  radius: 48,
                                ),
                                16.widthBox,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('First Name'),
                                      Text('Speciality'),
                                      Text('Location'),
                                      Text('Address')
                                    ],
                                  ),
                                )
                              ],
                            ),
                            16.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text('Rating'),
                                    8.heightBox,
                                    Text('4.2')
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Experience'),
                                    8.heightBox,
                                    Text('16 Years')
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Reviews'),
                                    8.heightBox,
                                    Text('17')
                                  ],
                                ),
                              ],
                            ),
                            16.heightBox,
                            Row(
                              children: [
                                Icon(Icons.money_outlined),
                                16.widthBox,
                                Text('Consultation Fee'),
                                Spacer(),
                                Text('UGX 4,000')
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton(
                      onPressed: () {print('icon');},
                      icon: Icon(
                        Icons.favorite_outline
                      ),
                    ),
                  )
                ],
              ),
            ),
            32.heightBox,
            futureDoctor(context)
          ],
        ),
      ),
    );
  }
}
