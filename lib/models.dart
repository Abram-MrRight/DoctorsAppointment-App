import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? id;
  final String fullName;
  final String? username;
  final String email;
  final String password;
  final String? phone;
  final bool? isDoctor;
  final String? allergies;
  final String? bloodType;
  final String? dob;
  final String? about;
  final String? location;
  final String? address;
  final String? speciality;
  final String? services;
  final Map<String, bool>? days;
  final String? punchIn;
  final String? punchOut;
  final String? profilePhoto;
  final String? rating;
  final String? consultationFee;
  final String? experience;

  UserModel(
      {
        this.id,
        required this.fullName,
        this.username,
        required this.email,
        required this.password,
        this.phone,
        this.isDoctor,
        this.allergies,
        this.bloodType,
        this.dob,
        this.about,
        this.location,
        this.address,
        this.speciality,
        this.services,
        this.days,
        this.punchIn,
        this.punchOut,
        this.profilePhoto,
        this.rating = '0.0',
        this.consultationFee,
        this.experience,
      });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id : json['id'],
      fullName: json['fullName'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      phone: json['phoneNumber'],
      isDoctor: json['isDoctor'],
      allergies: json['allergies'],
      bloodType: json['bloodType'],
      dob: json['dob'],
      about: json['about'],
      location: json['location'],
      address: json['address'],
      speciality: json['speciality'],
      services: json['services'],
      days: (json['days'] as Map?)?.cast<String, bool>(),
      punchIn: json['punchIn'],
      punchOut: json['punchOut'],
      profilePhoto: json['profilePhoto'],
      rating: json['rating'],
      consultationFee: json['consultationFee'],
      experience: json['experience'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'fullName': fullName,
      'username': username,
      'email': email,
      'password': password,
      'phoneNumber': phone,
      'isDoctor': isDoctor,
      'allergies': allergies,
      'bloodType': bloodType,
      'dob': dob,
      'about': about,
      'location': location,
      'address': address,
      'speciality': speciality,
      'services': services,
      'days': days,
      'punchIn': punchIn,
      'punchOut': punchOut,
      'profilePhoto': profilePhoto,
      'rating': rating,
      'consultationFee': consultationFee,
      'experience': experience,
    };
  }
}

class UserService {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> addUser(UserModel user) async {
    try {
      await usersCollection.add(user.toJson());
      return '';
    } on FirebaseAuthException catch(error) {
      return error.code;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return user;
    } catch (error) {
      print('Error logging in: $error');
      return null;
    }
  }

  Future<void> updateUser(UserModel user) async {
    if (user.id != null) {
      await usersCollection.doc(user.id).update(user.toJson());
    }
  }

  Future<void> deleteUser(String userId) async {
    await usersCollection.doc(userId).delete();
  }

  Future<UserModel?> getUserById(String userId) async {
    final DocumentSnapshot doc = await usersCollection.doc(userId).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    final QuerySnapshot querySnapshot = await usersCollection.get();
    return querySnapshot.docs.map((doc) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>)
        ..id = doc.id;
    }).toList();
  }

  Future<List<UserModel>> getDoctors() async {
    final QuerySnapshot querySnapshot = await usersCollection.where('isDoctor', isEqualTo: true).get();
    return querySnapshot.docs.map((doc) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>)
        ..id = doc.id;
    }).toList();
  }

  Future<List<UserModel>> getPatients() async {
    final QuerySnapshot querySnapshot = await usersCollection.where('isDoctor', isEqualTo: false).get();
    return querySnapshot.docs.map((doc) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>)
        ..id = doc.id;
    }).toList();
  }
}