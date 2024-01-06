import 'dart:convert';
import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/controllers/settings_controller.dart';
import 'package:doctors_appt/views/home_view/home_view.dart';
import 'package:doctors_appt/views/profile/profile_view.dart';
import 'package:doctors_appt/views/search_view/search_entry_view.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as ddio;
import 'package:url_launcher/url_launcher.dart';
import 'home.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  bool loadingNews = false;
  String networkStatus = '';
  List<Map<String, dynamic>> newsArticles = [];
  int count = 5;

  Future<void> fetchNewsArticles() async {
    setState(() {
      loadingNews = true;
    });

    final dio = ddio.Dio();
    try {
      ddio.Response response = await dio.get(
          'https://newsapi.org/v2/everything?q=medical|health&apiKey=c325c6a6563a4db89fcef2fc79f3b4a0');
      dynamic data = response.data;

      if (data == null) {
        networkStatus = 'News data unavailable!';
        return;
      } else if (data['status'] != 'ok') {
        networkStatus = 'Error! Failed to fetch news';
        return;
      } else if (data.runtimeType != <String, dynamic>{}.runtimeType) {
        networkStatus = 'News data corrupted!';
        return;
      }

      for (var item in data['articles']) {
        Map<String, dynamic> jsonArticle = {
          'url': item['url'] ?? '',
          'urlToImage': item['urlToImage'] ?? '',
          'source': item['source'] != null ? jsonEncode(item['source']) : null,
          'author': item['author'] ?? '',
          'title': item['title'] ?? '',
          'description': item['description'] ?? '',
          'publishedAt': item['publishedAt'] ?? '',
          'content': item['content'] ?? '',
        };
        newsArticles.add(jsonArticle);
      }
      newsArticles.shuffle();
    } catch (e) {
      networkStatus = e.toString();
    } finally {
      setState(() {
        loadingNews = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNewsArticles();
  }

  @override
  Widget build(BuildContext context) {
    var userController = Get.put(SettingsController());
    return Scaffold(
      drawer: const ProfileView(),
      appBar: AppBar(
        elevation: 0.0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage(
                  Appassets.imgDefault
              ),
              radius: 16,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyles.bold(
              title: "Hello ${userController.username.value}",
              size: AppSizes.size18.toDouble(),
              color: AppColors.whiteColor,
            ),
            const Text(
              "How are you today?",
              style: TextStyle(
                  fontSize: 12
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
                Icons.search
            ),
            onPressed: () {
              Get.to(() => const SearchEntryView());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionHeader('Upcoming Appointments'),
              _buildAppointmentCard('John Doe', 'January 15, 2024 - 2:00 PM'),
              _buildAppointmentCard('Jane Smith', 'January 18, 2024 - 3:30 PM'),

              16.heightBox,

              const HorizontalAdvertCardList(),

              _buildSectionHeader('Patient Records'),
              _buildPatientRecordCard('Patient A'),
              _buildPatientRecordCard('Patient B'),

              _buildSectionHeader('News Feed'),
              loadingNews ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.blueTheme,
                ),
              ) : RefreshIndicator(
                onRefresh: () async { fetchNewsArticles(); },
                child: newsArticles.isEmpty ?
                Text(networkStatus) :
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: count,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        newsArticles[index]['url'] != null ?
                        _buildNewsCard(newsArticles[index]) : Container()
                      ],
                    );
                  },
                ),
              ),
              TextButton(
                child: Text('Load More'),
                onPressed: () {
                  setState(() {
                    count += 10;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              if (title == 'Upcoming Appointments') {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Home(isDoctor: true, selectedIndex: 1))
                );
              }
              else if (title == 'Patient Records') {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Home(isDoctor: true, selectedIndex: 2))
                );
              }
              else if (title == 'News Feed') {
                // reload more news items
                fetchNewsArticles();
                setState(() {

                });
              }
            },
            child: Text(
              title == 'News Feed' ? 'Reload' : 'View All',
              style: TextStyle(
                  color: AppColors.blueTheme
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(String patientName, String time) {
    return Card(
      child: ListTile(
        title: Text('Patient: $patientName'),
        subtitle: Text('Time: $time'),
        onTap: () {
          // Add functionality for tapping on an appointment
        },
      ),
    );
  }

  Widget _buildPatientRecordCard(String patientName) {
    return Card(
      child: ListTile(
        title: Text('Patient: $patientName'),
        onTap: () {
          // Add functionality for tapping on a patient record
        },
      ),
    );
  }

  Widget _buildNewsCard(Map<String, dynamic> item) {
    return ListTile(
      leading: Image.network(
        item['urlToImage'],
        width: 64,
        fit: BoxFit.cover,
      ),
      title: Text(
        item['title'],
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        launchUrl(Uri.parse(item['url']));
      },
    );
  }
}
