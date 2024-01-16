import '../constants/colors.dart';
import '../constants/compound_data.dart';
import '../pages/search_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchEntryView extends StatelessWidget {
  const SearchEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SizedBox(
            height: 48,
            child: TextFormField(
              controller: inputControllers['search'],
              maxLines: 1,
              autofocus: true,
              onEditingComplete: () {
                Get.to(() => SearchView(
                  searchQuery: inputControllers['search']!.text,
                ));
              },
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: const TextStyle(
                  fontSize: 16,
                ),
                filled: true,
                fillColor: light,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide: BorderSide.none
                ),
              ),
            ),
          )
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Frequently searched",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: const Text("Cardiologist"),
              onTap: () {},
              splashColor: Colors.blue,
            ),
            ListTile(
              title: const Text("Cardiologist"),
              onTap: () {},
              splashColor: Colors.blue,
            ),
            ListTile(
              title: const Text("Cardiologist"),
              onTap: () {},
              splashColor: Colors.blue,
            )
          ],
        ),
      ),
      // body: CustomAppBar(),
    );
  }
}
