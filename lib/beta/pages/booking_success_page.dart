import '../components/widgets.dart';
import '../constants/compound_data.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/colors.dart';

class BookingSuccess extends StatelessWidget {
  const BookingSuccess ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 24
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    const Color(0xfffafcff),
                    blueTheme
                  ],
                  begin: AlignmentDirectional.bottomCenter,
                  end: AlignmentDirectional.topCenter
              )
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: const BackButton(
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFF80a5f4),
                      radius: 96,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xff779ff7),
                        radius: 64,
                        child: Icon(
                          Icons.check,
                          color: blueTheme,
                          size: 96,
                        ),
                      ),
                    ),
                    32.heightBox,
                    Text(
                      "Thank you!",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: blueTheme
                      ),
                    ),
                    16.heightBox,
                    Text(
                      "Your appointment is set",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: dark
                      ),
                    ),
                    16.heightBox,
                    Text(
                      "For"
                          " ${inputControllers['date']!.text}  "
                          "at ${inputControllers['appointmentTime']!.text}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24
          ),
          child: futureDone()
        )
    );
  }
}
