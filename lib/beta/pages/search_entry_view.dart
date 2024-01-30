import 'package:doctors_appt/beta/pages/category_details_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/widgets.dart';
import '../constants/colors.dart';
import '../constants/compound_data.dart';
import '../pages/search_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchEntryView extends StatefulWidget {
  const SearchEntryView({super.key});

  @override
  State<SearchEntryView> createState() => _SearchEntryViewState();
}

class _SearchEntryViewState extends State<SearchEntryView> {
  List<String> filteredMatches = [];

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
              onChanged: (value) {
                setState(() {
                  filteredMatches = specialistTypes
                      .where((match) =>
                      match.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for a specialist',
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
      body: Expanded(
        child: filteredMatches.isEmpty ? Center(child: text('No matches found!')) :
        ListView.builder(
          itemCount: filteredMatches.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(filteredMatches[index]),
              onTap: () {
                navigateTo(context, CategoryDetailsPage(specialistType: filteredMatches[index]));
              },
              // Add more functionality as needed
            );
          },
        ),
      ),
    );
  }
}
