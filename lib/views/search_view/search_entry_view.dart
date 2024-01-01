import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/views/search_view/search_view.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class SearchEntryView extends StatelessWidget {
  const SearchEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 48,
          child: TextFormField(
            controller: controller.searchQueryController,
            maxLines: 1,
            autofocus: true,
            onEditingComplete: () {
              Get.to(() => SearchView(
                searchQuery: controller.searchQueryController.text,
              ));
            },
            decoration: InputDecoration(
              hintText: AppStrings.search,
              hintStyle: const TextStyle(
                fontSize: 16
              ),
              filled: true,
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
        color: AppColors.bgDarkColor,
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

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.0, // Adjust the height as needed
      padding: EdgeInsets.all(8.0),
      color: Colors.blue, // Adjust the color as needed
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Your Title',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
