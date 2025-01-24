// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smile_x_doctor_app/controller/clinic_controller.dart';
import 'package:smile_x_doctor_app/utils/dio_handler.dart';
import 'package:smile_x_doctor_app/utils/routes/app_routes.dart';

class ClinicAddController extends GetxController {
  final Cnamecontroller = TextEditingController();
  final Cnumbercontroller = TextEditingController();
  final Cemailcontroller = TextEditingController();
  final Caddresscontroller = TextEditingController();

  var isLoading = false.obs;
  Future<void> createClinic(doctorId) async {
    isLoading.value = true; // Set loading state to true
    String endpoint = 'clinic/create';
    Map<String, dynamic> body = {
      "clinic_name": Cnamecontroller.text,
      "address": Caddresscontroller.text,
      "phone": Cnumbercontroller.text,
      "email": Cemailcontroller.text,
      "id": doctorId,
    };

    try {
      var response = await DioHandler.dioPOST(endpoint: endpoint, body: body);
      if (response != null && response['error'] == null) {
        log("Clinic created successfully: $response");

        // Fetch updated clinics list after the clinic is created
        final Ccontroller = Get.put(ClinicController());
        await Ccontroller.fetchClinics();

        // Show success message
        Get.snackbar("Success", "Clinic created successfully");

        // Delay the back navigation to allow the UI to process the snackbar

        Get.toNamed(AppRoutes.home); // Navigate back after showing the snackbar
      } else {
        Get.snackbar("Error", "Please fill all fields correctly.");
        log("Error while creating clinic: ${response['error']}");
      }
    } catch (e) {
      log("An error occurred: $e");
    } finally {
      isLoading.value = false; // Reset the loading state
    }
  }
}
