import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var workingDays = {
  'Monday' : false,
  'Tuesday' : false,
  'Wednesday' : false,
  'Thursday' : false,
  'Friday' : false,
  'Saturday' : false,
  'Sunday' : false,
};

Map<String, TextEditingController> inputControllers = {
  'fullName' : TextEditingController(),
  'username' : TextEditingController(),
  'email' : TextEditingController(),
  'phone' : TextEditingController(),
  'currentPassword' : TextEditingController(),
  'password' : TextEditingController(),
  'confirmPassword' : TextEditingController(),
  'location' : TextEditingController(),
  'allergies' : TextEditingController(),
  'bloodType' : TextEditingController(),
  'date' : TextEditingController(),
  'speciality' : TextEditingController(),
  'address' : TextEditingController(),
  'services' : TextEditingController(),
  'consultationFee' : TextEditingController(),
  'experience' : TextEditingController(),
  'profilePhoto' : TextEditingController(),
  'punchIn' : TextEditingController(text: '8:00 AM'),
  'punchOut' : TextEditingController(text: '5:00 PM'),
  'appointmentTime' : TextEditingController(),
  'message' : TextEditingController(),
  'search' : TextEditingController(),
  'rating' : TextEditingController(text: '0'),
  'title' : TextEditingController(),
};

List<String> specialistTypes = [
  'Allergist/Immunologist',
  'Anesthesiologist',
  'Cardiologist',
  'Dermatologist',
  'Endocrinologist',
  'Family Medicine Physician',
  'Gastroenterologist',
  'Hematologist',
  'Infectious Disease Specialist',
  'Internist',
  'Nephrologist',
  'Neurologist',
  'Obstetrician/Gynecologist',
  'Oncologist',
  'Ophthalmologist',
  'Orthopedic Surgeon',
  'Otolaryngologist (ENT)',
  'Pediatrician',
  'Physical Medicine & Rehab Specialist',
  'Pulmonologist',
  'Rheumatologist',
  'Sleep Medicine Specialist',
  'Sports Medicine Specialist',
  'Urologist',
  'Vascular Surgeon',
  'Psychiatrist',
  'Radiologist',
  'Emergency Medicine Physician',
  'Geriatrician',
  'Pain Management Specialist',
];

List<String> timeSlots = [
  '08:00 AM','09:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', '02:00 PM',
  '03:00 PM', '04:00 PM', '05:00 PM'
];

List<String> bloodTypes = ['A-', 'A+', 'B-', 'B+', 'O-', 'O+', 'AB-', 'AB+'];

List<Color> ratingStarColors = [Colors.grey, Colors.grey, Colors.grey,
  Colors.grey, Colors.grey];