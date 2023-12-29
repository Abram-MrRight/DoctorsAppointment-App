//In here first we create the users json model
// To parse this JSON data, do
//

class Patients {
  final int? patientId;
  final String? patientName;
  final String patientEmail;
  final String patientPassword;

  Patients({
    this.patientId,
     this.patientName,
    required this.patientEmail,
    required this.patientPassword,
  });

  factory Patients.fromMap(Map<String, dynamic> json) => Patients(
    patientId: json["patientId"],
    patientName:json["patientName"],
    patientEmail: json["patientEmail"],
    patientPassword: json["patientPassword"],
  );

  Map<String, dynamic> toMap() => {
    "patientId": patientId,
    "patientEmail": patientEmail,
    "patientPassword": patientPassword,
  };
}