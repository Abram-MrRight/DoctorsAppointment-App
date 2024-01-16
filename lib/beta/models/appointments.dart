import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String doctor;
  final String patient;
  final String phone;
  final String date;
  final String time;
  final String? message;
  final String? status;

  AppointmentModel({
    required this.doctor,
    required this.patient,
    required this.phone,
    required this.date,
    required this.time,
    this.message,
    this.status = 'upcoming',
  });

  Map<String, dynamic> toJson() {
    return {
      'doctor': doctor,
      'patient': patient,
      'phone': phone,
      'date': date,
      'time': time,
      'message': message,
      'status': status,
    };
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      doctor: json['doctor'],
      patient: json['patient'],
      phone: json['phone'],
      date: json['date'],
      time: json['time'],
      message: json['message'],
      status: json['status'],
    );
  }

  AppointmentModel copyWith({
    String? doctor,
    String? patient,
    String? phone,
    String? date,
    String? time,
    String? message,
    String? status,
  }) {
    return AppointmentModel(
      doctor: doctor ?? this.doctor,
      patient: patient ?? this.patient,
      phone: phone ?? this.phone,
      date: date ?? this.date,
      time: time ?? this.time,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _appointmentsCollection = 'appointments';

  AppointmentService() {
    _init();
  }

  Future<void> _init() async {
    List<AppointmentModel> appointments = await getAllAppointments();

  }

  Future<String?> saveAppointment(AppointmentModel appointment) async {
    try {
      await _firestore.collection(_appointmentsCollection).add(appointment.toJson());
      return '';
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  Future<void> updateAppointment(String appointmentId, AppointmentModel updatedAppointment) async {
    await _firestore.collection(_appointmentsCollection).doc(appointmentId).update(updatedAppointment.toJson());
  }

  Future<List<AppointmentModel>> getAllAppointments() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection(_appointmentsCollection).get();
    return snapshot.docs.map((doc) => AppointmentModel.fromJson(doc.data())).toList();
  }

  Future<List<AppointmentModel>> getAppointmentsForPatient(String userEmail) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection(_appointmentsCollection)
        .where('patient', isEqualTo: userEmail)
        .get();

    return snapshot.docs.map((doc) => AppointmentModel.fromJson(doc.data())).toList();
  }

  Future<List<AppointmentModel>> getAppointmentsForDoctor(String userEmail, {int? limit}) async {
    late QuerySnapshot<Map<String, dynamic>> snapshot;
    if (limit != null) {
      snapshot = await _firestore
          .collection(_appointmentsCollection)
          .where('doctor', isEqualTo: userEmail)
          .limit(limit)
          .orderBy('date', descending: true)
          .orderBy('time')
          .get();
    }
    else {
      snapshot = await _firestore
          .collection(_appointmentsCollection)
          .where('doctor', isEqualTo: userEmail)
          .orderBy('date', descending: true)
          .orderBy('time')
          .get();
    }

    return snapshot.docs.map((doc) => AppointmentModel.fromJson(doc.data())).toList();
  }

  Future<List<AppointmentModel>> getAppointmentsForUserByStatus(String userId, String status) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection(_appointmentsCollection)
        .where('patient', isEqualTo: userId)
        .where('status', isEqualTo: status)
        .get();

    return snapshot.docs.map((doc) => AppointmentModel.fromJson(doc.data())).toList();
  }

  Future<List<AppointmentModel>> getAppointmentsForUserByDate(String userId, String date) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection(_appointmentsCollection)
        .where('doctor', isEqualTo: userId)
        .where('date', isEqualTo: date)
        .get();

    return snapshot.docs.map((doc) => AppointmentModel.fromJson(doc.data())).toList();
  }

  Future<List<AppointmentModel>> getAppointmentsForUserToday(String userId) async {
    String today = DateTime.now().toLocal().toIso8601String().substring(0, 10);
    return getAppointmentsForUserByDate(userId, today);
  }

  Future<List<AppointmentModel>> getAppointmentsForUserTomorrow(String userId) async {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    String tomorrowDate = tomorrow.toLocal().toIso8601String().substring(0, 10);
    return getAppointmentsForUserByDate(userId, tomorrowDate);
  }

  Future<List<AppointmentModel>> getAppointmentsForUserThisWeek(String userId) async {
    DateTime now = DateTime.now();
    DateTime endOfWeek = DateTime(now.year, now.month, now.day + 6 - now.weekday);
    String endOfWeekDate = endOfWeek.toLocal().toIso8601String().substring(0, 10);

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection(_appointmentsCollection)
        .where('patient', isEqualTo: userId)
        .where('date', isGreaterThanOrEqualTo: DateTime.now().toLocal().toIso8601String().substring(0, 10))
        .where('date', isLessThanOrEqualTo: endOfWeekDate)
        .get();

    return snapshot.docs.map((doc) => AppointmentModel.fromJson(doc.data())).toList();
  }

  Future<void> deleteAppointment(String appointmentId) async {
    await _firestore.collection(_appointmentsCollection).doc(appointmentId).delete();
  }
}