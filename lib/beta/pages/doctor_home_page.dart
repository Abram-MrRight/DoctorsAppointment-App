import '../constants/strings.dart';
import '../pages/appointments_page.dart';
import '../pages/home_page.dart';
import '../pages/root_page.dart';
import '../pages/search_entry_view.dart';
import '../pages/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as ddio;
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:convert';

import '../components/adverts.dart';
import '../components/widgets.dart';
import '../constants/colors.dart';
import '../models/users.dart';

class DoctorHomePage extends StatefulWidget {
  UserModel currentUser;
  DoctorHomePage({super.key, required this.currentUser});
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
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionHeader('Upcoming Appointments'),
              futureUpcomingAppointments(),

              16.heightBox,

              const HorizontalAdvertCardList(),

              _buildSectionHeader('Patient Records'),
              _buildPatientRecordCard('Patient A'),
              _buildPatientRecordCard('Patient B'),

              _buildSectionHeader('News Feed'),
              loadingNews ? Center(
                child: CircularProgressIndicator(
                  color: blueTheme,
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
                    MaterialPageRoute(builder: (context) => RootPage(selectedIndex: 1, currentUser: widget.currentUser))
                );
              }
              else if (title == 'Patient Records') {
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => HomePage())
                // );
              }
              else if (title == 'News Feed') {
                // reload more news items
                fetchNewsArticles();
                setState(() {});
              }
            },
            child: Text(
              title == 'News Feed' ? 'Reload' : 'View All',
              style: TextStyle(
                  color: blueTheme
              ),
            ),
          ),
        ],
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
