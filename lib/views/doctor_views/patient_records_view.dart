import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/views/profile/profile_view.dart';
import 'package:doctors_appt/views/search_view/search_entry_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientRecordsPage extends StatefulWidget {
  const PatientRecordsPage({super.key});

  @override
  _PatientRecordsPageState createState() => _PatientRecordsPageState();
}

class _PatientRecordsPageState extends State<PatientRecordsPage> {
  List<Patient> patients = [
    Patient(
      name: 'John Doe',
      documents: [
        Document(name: 'Medical History', type: 'pdf'),
        Document(name: 'Lab Results', type: 'png'),
      ],
    ),
    Patient(
      name: 'Jane Smith',
      documents: [
        Document(name: 'Prescription', type: 'pdf'),
        Document(name: 'X-ray Report', type: 'jpg'),
      ],
    ),
    // Add more patient data as needed
  ];

  @override
  Widget build(BuildContext context) {
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
        title: AppStyles.bold(
          title: "Patient Records",
          size: AppSizes.size18.toDouble(),
          color: AppColors.whiteColor,
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
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          return PatientItem(patient: patients[index]);
        },
      ),
    );
  }
}

class Patient {
  final String name;
  final List<Document> documents;

  Patient({required this.name, required this.documents});
}

class Document {
  final String name;
  final String type;

  Document({required this.name, required this.type});
}

class PatientItem extends StatefulWidget {
  final Patient patient;

  PatientItem({required this.patient});

  @override
  _PatientItemState createState() => _PatientItemState();
}

class _PatientItemState extends State<PatientItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(widget.patient.name),
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        children: [
          if (isExpanded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.patient.documents.map((document) {
                return DocumentTile(document: document);
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class DocumentTile extends StatelessWidget {
  final Document document;

  DocumentTile({required this.document});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(document.name),
      subtitle: Text('Type: ${document.type}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Add functionality for download
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Add functionality for share
            },
          ),
        ],
      ),
    );
  }
}
