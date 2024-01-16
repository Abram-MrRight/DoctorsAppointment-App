import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appt/beta/models/users.dart';

class SearchModel {
  String searchTerm;
  int frequency;

  SearchModel({
    required this.searchTerm,
    required this.frequency,
  });

  Map<String, dynamic> toJson() {
    return {
      'searchTerm': searchTerm,
      'frequency': frequency,
    };
  }

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      searchTerm: json['searchTerm'],
      frequency: json['frequency'],
    );
  }
}

class SearchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'searchTerms';

  Future<void> saveOrUpdateSearchTerm(SearchModel searchModel) async {
    DocumentReference docRef = _firestore.collection(collectionName).doc(searchModel.searchTerm);
    // Check if the search term exists
    DocumentSnapshot docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      // If it exists, update the frequency
      await docRef.update({
        'frequency': FieldValue.increment(1),
      });
    } else {
      // If it doesn't exist, add a new document with frequency set to 1
      await docRef.set(searchModel.toJson());
    }
  }

  Future<List<SearchModel>> getTopSearchTerms() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection(collectionName)
        .orderBy('frequency', descending: true)
        .limit(5)
        .get();

    List<SearchModel> topSearchTerms = querySnapshot.docs
        .map((doc) => SearchModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return topSearchTerms;
  }

  Future<List<UserModel>> searchDoctors(String searchTerm) async {
    try {
      // Query doctors based on the search term in relevant fields
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('isDoctor', isEqualTo: true)
          .where('fullName', isGreaterThanOrEqualTo: searchTerm)
          // .where('location', whereIn: searchTerm.)
          .get();

      // Map the documents to UserModel
      List<UserModel> doctors = querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // You can add more conditions for other fields like speciality, location, services, etc.

      return doctors;
    } catch (e) {
      throw Exception('Error searching doctors: $e');
    }
  }
}