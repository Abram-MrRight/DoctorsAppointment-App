import '../constants/compound_data.dart';
import '../pages/sidebar.dart';
import 'package:flutter/material.dart';

import '../components/widgets.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../models/users.dart';
import 'category_details_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        elevation: 0.0,
        title: text('Categories'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage(
                  noImage
              ),
              radius: 16,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: specialistTypes.length,
            itemBuilder : (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  navigateTo(context, CategoryDetailsPage(specialistType: specialistTypes[index]));
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: blueTheme,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text(specialistTypes[index], color: light, size: 16),
                      10.heightBox,
                      FutureBuilder<List<UserModel>>(
                          future: UserService().getDoctorsByCategory(specialistTypes[index]),
                          builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
                            if(!snapshot.hasData){
                              return Center(child: text('Data unavailable', color: light));
                            }
                            else if (snapshot.connectionState == ConnectionState.active) {
                              return Center(child: progressIndicator());
                            }
                            else if (snapshot.hasData){
                              var numberOfSpecialists = snapshot.data!.length;
                              return text('$numberOfSpecialists '
                                  '${numberOfSpecialists == 1 ? 'specialist' : 'specialists'}',
                                  color: light.withOpacity(0.5));
                            }
                            else {
                              return text('Unknown error has occurred!', color: light);
                            }
                          }
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
