import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences _prefs;

  // Initialize SharedPreferences
  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save doctor details to shared preferences
  static Future<void> saveDoctorDetails(Map<String, String> details) async {
    await _prefs.setString('doctor_id', details['id'] ?? '');
    await _prefs.setString('doctor_name', details['name'] ?? '');
    await _prefs.setString(
        'doctor_email', details['email'] ?? ''); // Save email
    await _prefs.setString(
        'doctor_mobile', details['mobile'] ?? ''); // Save mobile number
    // Add other details if needed
  }

  // Save doctor ID to shared preferences
  static Future<void> saveDoctorId(String doctorId) async {
    await _prefs.setString('doctor_id', doctorId);
  }

  // Load doctor details from shared preferences
  static Map<String, String>? loadDoctorDetails() {
    String? doctorId = _prefs.getString('doctor_id');
    String? doctorName = _prefs.getString('doctor_name');
    String? doctorEmail = _prefs.getString('doctor_email'); // Retrieve email
    String? doctorMobile =
        _prefs.getString('doctor_mobile'); // Retrieve mobile number

    if (doctorId != null &&
        doctorName != null &&
        doctorEmail != null &&
        doctorMobile != null) {
      return {
        'id': doctorId,
        'name': doctorName,
        'email': doctorEmail, // Return email
        'mobile': doctorMobile, // Return mobile number
      };
    }

    return null;
  }

  // Load doctor ID from shared preferences
  static String? loadDoctorId() {
    return _prefs.getString('doctor_id');
  }

  // Clear all shared preferences
  static Future<void> clearSharedPreferences() async {
    await _prefs.clear();
  }
}
