import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUserProfile( {required String userId, required Map<String, String> userData}) async {
    try {
      print("Updating user profile for userId: $userId with data: $userData");
      await _firestore.collection('users').doc(userId).set(userData);
      print("User profile updated successfully!");
    } catch (e) {
      print("Error updating user profile: $e");
      throw e; // Re-throw the exception to propagate it to the caller
    }
  }

  String getCurrentUserId() {
    // Your implementation to get the current user's ID (uid)
    // Replace the following line with the actual logic from FirebaseAuth.
    return FirebaseAuth.instance.currentUser?.uid ?? '';
  }
}
