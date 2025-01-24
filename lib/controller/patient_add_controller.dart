// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x_doctor_app/controller/clinic_controller.dart';
import 'package:smile_x_doctor_app/utils/dio_handler.dart';

class PatientAddController extends GetxController {
  final Pnamecontroller = TextEditingController();
  final Pgendercontroller = TextEditingController();
  final Pnumbercontroller = TextEditingController();
  final Pemailcontroller = TextEditingController();
  final Paddresscontroller = TextEditingController();
  final Pcomplaintcontroller = TextEditingController();
  final Pgoalcontroller = TextEditingController();

  // Reactive variable to store the selected age
  var selectedAge = Rx<String?>(null);
  var selectedGender = Rx<String?>(null);
  var isLoading = false.obs;
  var clinicIdFromLogin = ''.obs;

  void setclientId(String clinicId) {
    clinicIdFromLogin.value = clinicId;
  }

  final clinicController = Get.put(ClinicController());
  Future<void> createPatient() async {
    isLoading.value = true; // Set loading to true when starting the API call

    // Validate the form and check if the clinic is selected
    if (clinicController.selectedClinic.value == null) {
      Get.snackbar("Error", "Please select a clinic.");
      isLoading.value = false; // Set loading to false if validation fails
      return;
    }

    var clinic = clinicController.selectedClinic.value;

    // Validate form fields (similar to your existing code)
    if (Pnamecontroller.text.isEmpty ||
        Paddresscontroller.text.isEmpty ||
        selectedAge.value == null ||
        selectedGender.value == null ||
        Pnumbercontroller.text.isEmpty ||
        Pemailcontroller.text.isEmpty) {
      Get.snackbar("Error", "Please fill in all required fields.");
      isLoading.value = false; // Set loading to false on failure
      return;
    }

    // API request
    if (clinic != null) {
      String endpoint = 'patients';
      Map<String, dynamic> body = {
        "patient_name": Pnamecontroller.text,
        "address": Paddresscontroller.text,
        "age": selectedAge.value,
        "gender": selectedGender.value,
        "phone_number": Pnumbercontroller.text,
        "mail": Pemailcontroller.text,
        "clinic_id": clinicIdFromLogin.value,
      };

      // Inside createPatient()
      try {
        var response = await DioHandler.dioPOST(endpoint: endpoint, body: body);
        if (response != null && response['error'] == null) {
          final controller = Get.put(ClinicController());
          controller.selectedClinic.value = clinic;
          Get.back();
          Get.snackbar("Success", "Patient created successfully",
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          Get.back();
          Get.snackbar("Error", "Failed to create patient. Please try again.",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } catch (e) {
        Get.snackbar("Error", "An error occurred. Please try again.",
            backgroundColor: Colors.red, colorText: Colors.white);
      } finally {
        isLoading.value =
            false; // Set loading to false when done (success or failure)
      }
    }
  }

// Function to validate phone number format
  bool isValidPhoneNumber(String phoneNumber) {
    // Regular expression for validating phone number (only digits, and length should be between 10-15)
    final phoneRegExp = RegExp(r'^[0-9]{10,15}$');
    return phoneRegExp.hasMatch(phoneNumber);
  }

  void resetForm() {
    // Clear all the text controllers
    Pnamecontroller.clear();
    Pgendercontroller.clear();
    Pnumbercontroller.clear();
    Pemailcontroller.clear();
    Paddresscontroller.clear();
    Pcomplaintcontroller.clear();
    Pgoalcontroller.clear();

    // Reset the reactive variables
    selectedAge.value = null;
    selectedGender.value = null;

    // Optionally reset the clinic selection (if needed)
    clinicController.selectedClinic.value = {};
    clinicController.selectedClinic.value = null;
  }

  void resetClinicId() {
    clinicIdFromLogin.value = '';
  }
}
