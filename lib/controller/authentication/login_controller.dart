import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x_doctor_app/controller/appointment_list.dart';
import 'package:smile_x_doctor_app/controller/clinic_controller.dart';
import 'package:smile_x_doctor_app/controller/patient_add_controller.dart';
import 'package:smile_x_doctor_app/controller/patient_list_controller.dart';
import 'package:smile_x_doctor_app/utils/dio_handler.dart';
import 'package:smile_x_doctor_app/utils/shared_preference.dart';
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

  @override
  void onInit() {
    super.onInit();
    _checkAutoLogin();
  }

  void _checkAutoLogin() async {
    // Load doctor details from SharedPreferences
    var doctorDetails = SharedPreferencesService.loadDoctorDetails();
    var doctorId = SharedPreferencesService.loadDoctorId();

    if (doctorDetails != null && doctorId != null) {
      // Auto login: doctor is already logged in
      doctorname.value = doctorDetails['name'] ?? 'Unknown Doctor';
      doctorDetailsList.value = [
        doctorDetails['id'] ?? '',
        doctorDetails['doctor_id'] ?? '',
        doctorDetails['name'] ?? '',
        doctorDetails['email'] ?? '',
        doctorDetails['mobile'] ?? '',
      ];
      doctorId = doctorDetails['id'] ?? '';

      // Navigate to the home screen
      navigationToHome();
    } else {
      // Navigate to login screen if not logged in
      Get.toNamed(AppRoutes.login);
    }
  }

  // Navigation to home
  // void navigationToHome() {
  //   // Retrieve doctor ID from SharedPreferences
  //   final String? storedDoctorId = SharedPreferencesService.loadDoctorId();

  //   if (storedDoctorId != null && storedDoctorId.isNotEmpty) {
  //     // Doctor ID is available, proceed to home screen
  //     final cController = Get.put(ClinicController());
  //     cController.setDoctorId(storedDoctorId);
  //     // cController.fetchClinics(
  //     //     storedDoctorId); // Pass the stored doctor ID for clinic info
  //     log("Clinic doctor id: $storedDoctorId");

  //     final acontroller = Get.put(AppointmentsController());
  //     acontroller.setDoctorId(
  //         storedDoctorId); // Pass the stored doctor ID for appointments

  //     // Pass doctor ID as a List<String>
  //     Get.offNamed(
  //       AppRoutes.home,
  //       arguments:
  //           doctorDetailsList, // Ensure this is a List<String> with valid data
  //     );
  //   } else {
  //     // Handle the case when doctor ID is missing or invalid
  //     Get.snackbar(
  //       "Error",
  //       "Doctor details are missing.",
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }

  //   // Clear text fields after successful login

  // }
  void navigationToHome() {
    final String? storedDoctorId = SharedPreferencesService.loadDoctorId();

    if (storedDoctorId != null && storedDoctorId.isNotEmpty) {
      final clinicController = Get.put(ClinicController());
      clinicController.setDoctorId(storedDoctorId);
      clinicController.selectedClinic.value = null;

      final acontroller = Get.put(AppointmentsController());
      acontroller.setDoctorId(storedDoctorId);

      // Navigate to the home screen
      Get.offNamed(AppRoutes.home);
    } else {
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
    isLoading.value = true; // Start loading when login is triggered

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

      isLoading.value = false; // Stop loading after receiving the response

      // Check if response is valid and of type Map
      if (response != null && response is Map) {
        // Check if login is successful
        if (response['message'] == "Login successful") {
          final doctor = response['doctor'];

          if (doctor != null) {
            doctorname.value = doctor['name'] ?? 'Unknown Doctor';

            // Save doctor details to SharedPreferences
            await SharedPreferencesService.saveDoctorDetails({
              'id': doctor['id']?.toString() ?? '',
              'doctor_id': doctor['doctor_id']?.toString() ?? '',
              'name': doctor['name'] ?? 'Unknown',
              'email': doctor['email'] ?? 'No Email',
              'mobile': doctor['mobile'] ?? 'No Mobile',
            });

            // Save doctor ID to SharedPreferences
            await SharedPreferencesService.saveDoctorId(
                doctor['id']?.toString() ?? '');

            // Save the doctor details in a list (if needed)
            doctorDetailsList.value = [
              doctor['id']?.toString() ?? '',
              doctor['doctor_id']?.toString() ?? '',
              doctor['name'] ?? 'Unknown',
              doctor['email'] ?? 'No Email',
              doctor['mobile'] ?? 'No Mobile',
            ];

            doctorId.value =
                doctor['id']?.toString() ?? ''; // Ensure doctorId is a string

            update(); // Update the UI after setting the doctor details

            // Now that the doctor details are saved, navigate to the home screen
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
          // Show login error message if credentials are invalid
          final errorMessage = response['message'] ?? "Invalid credentials";
          Get.snackbar(
            "Login Failed",
            errorMessage,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        // Handle case when the response is not valid or null
        Get.snackbar(
          "Error",
          "An unexpected error occurred. Please try again.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Catch any exceptions during the login request
      isLoading.value = false; // Stop loading on error

      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      log("Login exception: $e");
    }
    emailcontroller.clear();
    passwordcontroller.clear();
  }

  void logout() async {
    // Clear all SharedPreferences data
    await SharedPreferencesService.clearSharedPreferences();

    final patient = Get.put(PatientsListController());
    patient.clearPatientsData();

    final appointment = Get.put(AppointmentsController());
    appointment.clearAppointments();
    // Clear the ClinicController state
    final clinicController = Get.put(ClinicController());
    clinicController.clearclinic(); // This will reset the clinic values

    // Explicitly reset selected clinic and selected clinic ID
    clinicController.selectedClinic.value = null;
    clinicController.selectedClinicId.value = null;

    // Reset the PatientAddController's clinicIdFromLogin
    final patientAddController = Get.put(PatientAddController());
    patientAddController.resetClinicId(); // Reset clinic ID here

    // Clear doctor details and reset reactive variables
    doctorname.value = '';
    doctorDetailsList.value = [];
    doctorId.value = '';

    // Navigate to the login screen
    Get.toNamed(AppRoutes.splash);
  }
}
