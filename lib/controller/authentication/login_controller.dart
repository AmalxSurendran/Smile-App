// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x_doctor_app/controller/clinic_controller.dart';
import 'package:smile_x_doctor_app/controller/profile_controller.dart';
import 'package:smile_x_doctor_app/utils/dio_handler.dart';
import '../../utils/routes/app_routes.dart';

class LoginController extends GetxController {
  var isPasswordHidden = true.obs;
  var isRememberMe = false.obs;
  var isLoading = false.obs;
  var doctorDetailsList = <String>[].obs; // List to hold doctor details
  var doctorId = "".obs;
  var doctorname = "".obs;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Method to toggle "Remember Me" checkbox
  void toggleRememberMe(bool? newValue) {
    isRememberMe.value = newValue ?? false;
  }

  // Navigation to home
  void navigationToHome() {
    if (doctorDetailsList.isNotEmpty) {
      final cController = Get.put(ClinicController());
      cController.fetchclinc(doctorDetailsList[0]);
      log("clicnic doctor id: ${doctorDetailsList[0]}");
      final pcontroller = Get.put(ProfileController());
      pcontroller.fetchProfile(doctorDetailsList[0]);

      Get.offNamed(
        AppRoutes.home,
        arguments: doctorDetailsList.value,
      );
    } else {
      // Handle the case when doctorDetailsList is empty
      Get.snackbar(
        "Error",
        "Doctor details are missing.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    emailcontroller.clear();
    passwordcontroller.clear();
  }

  Future<void> login() async {
    isLoading.value = true;
    const String loginEndpoint = "login";
    final body = {
      "username": emailcontroller.text,
      "password": passwordcontroller.text,
    };

    try {
      final response = await DioHandler.dioPOST(
        endpoint: loginEndpoint,
        body: body,
      );

      isLoading.value = false;

      if (response != null && response is Map) {
        if (response['message'] == "Login successful") {
          final doctor = response['doctor'];

          // Check if doctor data is valid
          if (doctor != null) {
            doctorname.value = doctor['name'] ?? '';
            doctorDetailsList.value = [
              doctor['doctor_id'] ?? '',
              doctor['name'] ?? '',
              doctor['email'] ?? '',
              doctor['mobile'] ?? '',
            ];
            update();
            doctorId.value = doctor['doctor_id'] ?? '';

            log('doctorDetailsList: $doctorDetailsList');
            log("Doctor ID: ${doctorId.value}");

            // Ensure doctor details are set before navigating
            // Delay to ensure state updates
            navigationToHome();
            log("Login successful: $response");
          } else {
            // Handle case where doctor data is missing or invalid
            Get.snackbar(
              "Error",
              "Doctor details not found in the response.",
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } else {
          final errorMessage = response['message'] ?? "Invalid credentials";
          Get.snackbar(
            "Login Failed",
            errorMessage,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      // Error handling for unexpected issues
      isLoading.value = false;

      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      log("Login exception: $e");
    }
  }
}
