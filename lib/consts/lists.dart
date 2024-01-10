import 'package:doctors_appt/consts/consts.dart';
import 'package:doctors_appt/consts/strings.dart';

import 'images.dart';

var iconsList = [
  Appassets.ic_body,
  Appassets.ic_ear,
  Appassets.ic_heart,
  Appassets.ic_kidney,
  Appassets.ic_leg,
  Appassets.ic_liver,


];

var iconsTitleList = [
  AppStrings.body,
  AppStrings.ear,
  AppStrings.liver,
  AppStrings.heart,
  AppStrings.kidney,
  AppStrings.legs,
];

List<String> specialists = [
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
  'Obstetrician/Gynecologist (OB/GYN)',
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

var settingsList = [
 AppStrings.changePassword,
  AppStrings.termsConditions,
  AppStrings.signOut
];

var settingsListIcon = [
  Icons.lock,
  Icons.note,
  Icons.logout
];

var workingDays = {
  'Monday' : false,
  'Tuesday' : false,
  'Wednesday' : false,
  'Thursday' : false,
  'Friday' : false,
  'Saturday' : false,
  'Sunday' : false,
};