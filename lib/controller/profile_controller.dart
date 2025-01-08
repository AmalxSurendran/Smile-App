import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x_doctor_app/model/profile_model.dart';
import 'package:smile_x_doctor_app/utils/dio_handler.dart';

class ProfileController extends GetxController {
  var doctorInitials = ''.obs;

  // Account screen
  var isEditing = false.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Fetch profile for a single doctor
  var doctorDetailsList = <String>[].obs;
  void fetchProfile(String doctorId) async {
    try {
      var response = await DioHandler.dioGET(endpoint: 'doctors/$doctorId');
      log('Raw Response: $response');

      if (response is String) {
        response = jsonDecode(response);
      }

      if (response is Map && response.containsKey('doctor')) {
        final doctorProfile = response['doctor'] as Map<String, dynamic>;
        final doctor = Doctor.fromJson(doctorProfile);
        doctorInitials.value = _extractInitials(doctor.name);

        // Storing doctor details in the list
        doctorDetailsList.value = [
          doctor.name,
          doctor.email,
          doctor.mobile,
          doctor.username,
        ];

        // Set the values in the controllers
        nameController.text = doctor.name;
        mobileController.text = doctor.mobile;
        emailController.text = doctor.email;

        log("Doctor Profile - Name: ${doctor.name}, Email: ${doctor.email}, Mobile: ${doctor.mobile}, Username: ${doctor.username}");
      } else {
        log('Unexpected format for doctor profile: $response');
      }
    } catch (e) {
      log('Error decoding response: $e');
    }
  }

  String _extractInitials(String name) {
    if (name.isEmpty) return '';
    final parts = name.split(' ');
    final firstNameInitial = parts.isNotEmpty ? parts[0][0] : '';
    final lastNameInitial = parts.length > 1 ? parts[1][0] : '';
    return (firstNameInitial + lastNameInitial).toUpperCase();
  }
}
