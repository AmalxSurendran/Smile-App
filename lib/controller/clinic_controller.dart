import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x_doctor_app/utils/dio_handler.dart';

class ClinicController extends GetxController {
  final clinicController = TextEditingController();
  var selectedClinic = Rx<Map<String, dynamic>?>(
      null); // Ensure it starts as null or with a valid clinic map
  var clinics = <Map<String, dynamic>>[].obs;

  Future<void> fetchclinc(String doctorId) async {
    try {
      final response =
          await DioHandler.dioGET(endpoint: "clinic/doctor/$doctorId");
      log('clinic response: $response');
      if (response != null && response["clinics"] != null) {
        clinics.value = List<Map<String, dynamic>>.from(response["clinics"]);
        log('clinics list updated: $clinics');
      } else {
        log('No clinics found in the response.');
      }
    } catch (e) {
      log("Error fetching clinics: $e");
    }
  }

  // Update the selected clinic
  void selectClinic(Map<String, dynamic> clinic) {
    selectedClinic.value = clinic;
    log('Selected clinic is: $clinic');
  }

  @override
  void onInit() {
    super.onInit();
    fetchclinc('doctorId'); // Pass the required doctorId argument
  }
}
