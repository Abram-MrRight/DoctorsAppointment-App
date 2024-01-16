import 'package:awesome_notifications/awesome_notifications.dart';
import '../components/adverts.dart';
import '../components/widgets.dart';
import '../constants/strings.dart';
import '../pages/search_entry_view.dart';
import '../pages/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/colors.dart';
import '../controllers/notifications.dart';
import '../models/users.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationsController.onActionReceivedMethod,
        onNotificationCreatedMethod: NotificationsController.onNotificationCreatedMethod,
        onDismissActionReceivedMethod: NotificationsController.onDismissActionReceivedMethod,
        onNotificationDisplayedMethod: NotificationsController.onNotificationDisplayedMethod
    );
  }

  Future<void> initialize() async {
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        elevation: 0.0,
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
        title: futureUser(),
        actions: [
          IconButton(
            icon: const Icon(
                Icons.search
            ),
            onPressed: () {
              navigateTo(context, const SearchEntryView());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  carouselCategory(),
                  20.heightBox,
                  const HorizontalAdvertCardList(),
                  10.heightBox,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Popular Doctors",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blueTheme,
                        )
                    ),
                  ),
                  10.heightBox,
                  popularDoctor(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Doctors Near You',
                        style: TextStyle(
                            color: blueTheme,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      GestureDetector(
                        onTap: (){},
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: text('View All', color: blueTheme, size: 14)
                        ),
                      ),
                    ],
                  ),
                  10.heightBox,
                  futureDoctorsNearYou(),
                  10.heightBox,
                ],
              )
          )
      ),
    );
  }
}
