// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:smile_x_doctor_app/utils/dio_handler.dart';

class PatientsListController extends GetxController {
  var patients = <Map<String, dynamic>>[].obs;
  var clinicIdFromLogin = ''.obs;
  var isLoading = false.obs;

  // Method to fetch patients
  Future<void> fetchPatients(String clinicId) async {
    try {
      isLoading.value = true;
      patients.clear();

      log('Fetching patients for clinic ID: $clinicId');
      final data = await DioHandler.dioGET(endpoint: 'patients/pbc/$clinicId');

      if (data != null &&
          data['patients'] is List &&
          data['patients'].isNotEmpty) {
        // log('Patients data fetched: ${data['patients']}');
        patients.value = List<Map<String, dynamic>>.from(
          data['patients'].map((patient) {
            return {
              'id': patient['id'],
              'patient_id': patient['patient_id'],
              'patient_name': patient['patient_name'],
              'address': patient['address'],
              'phone_number': patient['phone_number'],
              'mail': patient['mail'],
            };
          }),
        );
      } else {
        log('No patients found for clinic ID: $clinicId');
        patients.clear();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        log("No patients found for clinic ID: $clinicId");
        patients.clear();
      } else {
        log('DioException: ${e.message}');
      }
    } catch (e) {
      log('Error fetching patients: $e');
    } finally {
      // Set isLoading to false when data fetching ends
      isLoading.value = false;
    }
  }

  // Method to handle clinic change
  void onClinicChanged(String clinicId) {
    clinicIdFromLogin.value = clinicId;
    fetchPatients(clinicId); // Fetch patients when clinic is changed
  }

  // Method to clear the data when logging out
  void clearPatientsData() {
    patients.clear(); // Clear the list of patients
    clinicIdFromLogin.value = ''; // Clear the clinicId
    isLoading.value = false; // Reset loading state
    log('Patients data cleared on logout');
  }
}
