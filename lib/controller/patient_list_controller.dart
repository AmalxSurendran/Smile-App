import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:smile_x_doctor_app/utils/dio_handler.dart'; // Import DioHandler class

class PatientsListController extends GetxController {
  // Reactive list to store patient data as Map<String, dynamic>
  var patients = <Map<String, dynamic>>[].obs;

  // Reactive variable to store clinicId
  var selectedClinicId = ''.obs;

  // Method to fetch patients
  Future<void> fetchPatients(String clinicId) async {
    print('Fetching patients for clinic ID: $clinicId');
    try {
      // Clear previous patients list before fetching new data
      patients.clear();

      log('Fetching patients for clinic ID: $clinicId');
      final data = await DioHandler.dioGET(endpoint: 'patients/pbc/$clinicId');

      // Log the response data for debugging
      log('Fetched data: $data');

      if (data != null && data['patients'] is List) {
        log('Patients data fetched: ${data['patients']}');
        patients.value = List<Map<String, dynamic>>.from(
          data['patients'].map((patient) {
            log('Processing patient: $patient');
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
        log('Processed patients: ${patients.value}');
      } else {
        log('No patients found for clinic ID: $clinicId');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        log("No patients found for clinic ID: $clinicId");
        // Handle no data scenario (e.g., show a message to the user)
      } else {
        log('DioException: ${e.message}');
      }
    } catch (e) {
      log('Error fetching patients: $e');
    }
  }

  // Method to handle clinic change
  void onClinicChanged(String clinicId) {
    selectedClinicId.value = clinicId;
    fetchPatients(clinicId); // Fetch patients when clinic is changed
  }
}
