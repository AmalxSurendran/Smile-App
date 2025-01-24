import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x_doctor_app/utils/dio_handler.dart';
import 'package:smile_x_doctor_app/utils/routes/app_routes.dart';

class SignupController extends GetxController {
  var isPasswordHidden = true.obs;
  var isRememberMe = false.obs;
  var isLoading = false.obs;

  var doctorDetailsList = <String>[].obs;
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Method to toggle "Remember Me" checkbox
  void toggleRememberMe(bool? newValue) {
    isRememberMe.value = newValue ?? false;
  }

  //Navigation to home
  void navigationToHome() {
    namecontroller.clear();
    emailcontroller.clear();
    phonecontroller.clear();
    usernamecontroller.clear();
    passwordcontroller.clear();

    Get.toNamed(AppRoutes.login);
  }

  Future<void> signUp() async {
    const String signUpEndpoint = "doctors";
    final body = {
      "username": usernamecontroller.text,
      "name": namecontroller.text,
      "email": emailcontroller.text,
      "mobile": phonecontroller.text,
      "password": passwordcontroller.text,
    };
    log('signup body: $body');
    try {
      isLoading.value = true; // Set loading state to true

      final response = await DioHandler.dioPOST(
        endpoint: signUpEndpoint,
        body: body,
      );

      isLoading.value = false; // Set loading state to false after response

      if (response != null &&
          response is Map &&
          response['message'] == "Doctor created successfully") {
        log('sIGNUP RESPONSE: $response');
        // Extract doctor's details
        final doctor = response['doctor'];
        doctorDetailsList.value = [
          doctor['name'] ?? '',
          doctor['email'] ?? '',
          doctor['mobile'] ?? '',
          doctor['doctor_id'] ?? '',
        ];
        log('Signup details: $doctorDetailsList');
        Get.snackbar(
          "Sign-Up Successful",
          "please login to continue",
          duration: const Duration(seconds: 3),
        );

        navigationToHome();
        log("Signup successful: $response");
      } else {
        final errorMessage = response is Map && response['message'] != null
            ? response['message']
            : "Failed to create account. Please try again.";
        Get.snackbar(
          "Signup Failed",
          errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        log("Sign-Up failed: $response");
      }
    } catch (e) {
      // Display error snack bar
      isLoading.value = false; // Set loading state to false if error occurs

      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      log("Sign-Up exception: $e");
    }
  }
}
