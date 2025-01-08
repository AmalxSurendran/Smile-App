import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x_doctor_app/utils/dio_handler.dart';
import '../../utils/routes/app_routes.dart';

class LoginController extends GetxController {
  var isPasswordHidden = true.obs;
  var isRememberMe = false.obs;

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

  //Navigation to home
  void navigationToHome() {
    Get.offNamed(AppRoutes.home);
    emailcontroller.clear();
    passwordcontroller.clear();
  }

  Future<void> login() async {
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

      if (response != null &&
          response is Map &&
          response['message'] == "Login successful") {
        Get.snackbar(
          "Login Successful",
          "Welcome back, ${response['doctor']['name']}!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        navigationToHome();
        log("Login successful: $response");
      } else {
        final errorMessage = response is Map && response['message'] != null
            ? response['message']
            : "Invalid credentials or server error.";
        Get.snackbar(
          "Login Failed",
          errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        log("Login failed: $response");
      }
    } catch (e) {
      // Display error snack bar
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
