import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appt/beta/components/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? id;
  final String? fullName;
  final String? username;
  final String? email;
  final String? password;
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
  final String rating;
  final String? consultationFee;
  final String? experience;

  UserModel(
    {
      this.id,
      this.fullName, this.username,
     this.email,
     this.password,
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
      rating: json['rating'] ?? '0.0',
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

  UserModel copyWith({
    String? id,
    String? fullName,
    String? username,
    String? email,
    String? password,
    String? phone,
    bool? isDoctor,
    String? allergies,
    String? bloodType,
    String? dob,
    String? about,
    String? location,
    String? address,
    String? speciality,
    String? services,
    Map<String, bool>? days,
    String? punchIn,
    String? punchOut,
    String? profilePhoto,
    String? rating,
    String? consultationFee,
    String? experience,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      isDoctor: isDoctor ?? this.isDoctor,
      allergies: allergies ?? this.allergies,
      bloodType: bloodType ?? this.bloodType,
      dob: dob ?? this.dob,
      about: about ?? this.about,
      location: location ?? this.location,
      address: address ?? this.address,
      speciality: speciality ?? this.speciality,
      services: services ?? this.services,
      days: days ?? this.days,
      punchIn: punchIn ?? this.punchIn,
      punchOut: punchOut ?? this.punchOut,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      rating: rating ?? this.rating,
      consultationFee: consultationFee ?? this.consultationFee,
      experience: experience ?? this.experience,
    );
  }
}

class UserService {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserService() {
    CollectionReference users = usersCollection.withConverter<UserModel>(
        fromFirestore: (snapshots, _) => UserModel.fromJson(snapshots.data()!),
        toFirestore: (user, _) => user.toJson()
    );
  }

  Future<User?> signUp(UserModel user) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: user.email!,
          password: user.password!
      );
      user = user.copyWith(id: credential.user!.uid);
      await credential.user?.updateDisplayName(user.fullName);
      await usersCollection.doc(credential.user!.uid).set(user.toJson());
      return credential.user;
    } on FirebaseAuthException catch(error) {
      toast(error.code);
      return null;
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

  Future<String> updateUser(UserModel user) async {
    try {
      // Verify that the user ID is available
      if (user.id == null) {
        return 'User ID is null';
      }

      // Retrieve the document using the user ID
      DocumentSnapshot documentSnapshot = await usersCollection.doc(user.id!).get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Update the existing document with the new data
        await usersCollection.doc(user.id!).update(user.toJson());
        return '';
      } else {
        return 'Document not found for user ID: ${user.id}';
      }
    } on FirebaseException catch (error) {
      return error.message!;
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

  Future<List<UserModel>> getUsersByEmail(String userEmail) async {
    final QuerySnapshot querySnapshot =
    await usersCollection.where('email', isEqualTo: userEmail).get();

    return querySnapshot.docs.map((doc) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>)
        ..id = doc.id;
    }).toList();
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

  Future<UserModel?> getUser() async {
    QuerySnapshot querySnapshot = await usersCollection.where('id', isEqualTo: _auth.currentUser?.uid).get();
    List<UserModel> x = querySnapshot.docs.map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>)).toList();
    if (x.length == 0) return null;
    else return x.first;
  }

  Future<UserModel> getUserByEmail(String email) async {
    QuerySnapshot querySnapshot = await usersCollection.where('email', isEqualTo: email).get();
    return querySnapshot.docs.map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>)).toList()[0];
  }

  Future<List<UserModel>> getDoctorsByCategory(String speciality) async {
    QuerySnapshot querySnapshot = await usersCollection.where('speciality', isEqualTo: speciality).get();
    return querySnapshot.docs.map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>)).toList();
  }
}