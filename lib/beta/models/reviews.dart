import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String patientName;
  final String doctorId;
  final int rating;
  final String message;
  final String submitDate;
  final String? title;
  final int inappropriateFlags;
  final int spamFlags;

  ReviewModel({
    required this.patientName,
    required this.doctorId,
    required this.rating,
    required this.message,
    required this.submitDate,
    this.title,
    this.inappropriateFlags = 0,
    this.spamFlags = 0,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      patientName: json['patientName'],
      doctorId: json['doctorId'],
      rating: json['rating'],
      message: json['message'],
      submitDate: json['submitDate'],
      title: json['title'],
      inappropriateFlags: json['inappropriateFlags'] ?? 0,
      spamFlags: json['spamFlags'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'doctorId': doctorId,
      'rating': rating,
      'message': message,
      'submitDate': submitDate,
      'title': title,
      'inappropriateFlags': inappropriateFlags,
      'spamFlags': spamFlags,
    };
  }
}

class ReviewService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save a new review to Firestore
  Future<String?> saveReview(ReviewModel review) async {
    try {
      final result = await _firestore.collection('reviews').add(review.toJson());
      return '';
    } on FirebaseException catch (error) {
      return error!.message;
    }
  }

  // Retrieve all reviews
  Future<List<ReviewModel>> getAllReviews() async {
    QuerySnapshot querySnapshot = await _firestore.collection('reviews').get();

    return querySnapshot.docs
        .map((doc) => ReviewModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Return reviews about a specific doctor
  Future<List<ReviewModel>> getReviewsForDoctor(String email) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('reviews')
        .where('doctorId', isEqualTo: email)
        .get();

    return querySnapshot.docs
        .map((doc) => ReviewModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Calculate the average rating of a doctor
  Future<double> calculateAverageRatingForDoctor(String doctorId) async {
    List<ReviewModel> doctorReviews = await getReviewsForDoctor(doctorId);

    if (doctorReviews.isEmpty) {
      return 0.0;
    }

    double totalRating = doctorReviews.map((review) => review.rating).reduce((a, b) => a + b) as double;
    return totalRating / doctorReviews.length;
  }

  // Delete a review
  Future<void> deleteReview(String reviewId) async {
    await _firestore.collection('reviews').doc(reviewId).delete();
  }

  // Update a review
  Future<void> updateReview(String reviewId, ReviewModel updatedReview) async {
    await _firestore.collection('reviews').doc(reviewId).update(updatedReview.toJson());
  }
}