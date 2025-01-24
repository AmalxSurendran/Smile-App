import 'package:get/get.dart';
import 'package:smile_x_doctor_app/utils/shared_preference.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  var doctorInitials = ''.obs;
  var isEditing = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Load doctor details from SharedPreferences
  void loadDoctorDetails() async {
    Map<String, String>? details = SharedPreferencesService.loadDoctorDetails();
    if (details != null) {
      nameController.text = details['name'] ?? '';
      mobileController.text = details['mobile'] ?? '';
      emailController.text = details['email'] ?? '';
      doctorInitials.value = extractInitials(details['name'] ?? '');
    }
  }

  // Method to save the profile changes to SharedPreferences
  void saveProfile() async {
    final updatedDetails = {
      'id': SharedPreferencesService.loadDoctorId() ?? '',
      'name': nameController.text,
      'email': emailController.text,
      'mobile': mobileController.text,
    };

    // Save the updated details
    await SharedPreferencesService.saveDoctorDetails(updatedDetails);
    // Optionally, update initials or any other state
    doctorInitials.value = extractInitials(nameController.text);
  }

  // Method to extract initials
  String extractInitials(String name) {
    if (name.isEmpty) return '';
    final parts = name.split(' ');
    final firstNameInitial = parts.isNotEmpty ? parts[0][0] : '';
    final lastNameInitial = parts.length > 1 ? parts[1][0] : '';
    return (firstNameInitial + lastNameInitial).toUpperCase();
  }
}
