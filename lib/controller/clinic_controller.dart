import 'dart:developer';
import 'package:get/get.dart';
import 'package:smile_x_doctor_app/utils/dio_handler.dart'; // Assuming AppUtils is a utility class you use

class ClinicController extends GetxController {
  var selectedClinic =
      Rx<Map<String, dynamic>?>(null); // Rx for selected clinic
  var clinics = <Map<String, dynamic>>[].obs; // Reactive list for clinics
  var doctorId = Rx<String?>(null); // Doctor ID
  var selectedClinicId = Rx<String?>(null); // Reactive for selected clinic ID

  @override
  void onInit() async {
    super.onInit();
    if (doctorId.value != null) {
      await fetchClinics();
    } else {
      log("Doctor ID is not set");
    }
  }

  @override
  void onClose() {
    super.onClose();
    // Clean up resources if needed
    clinics.clear();
    selectedClinic.value = null;
    selectedClinicId.value = null;
  }

  // Set doctorId and fetch clinics
  void setDoctorId(String doctorId) {
    this.doctorId.value = doctorId;
    log('Doctor ID set: $doctorId');
    fetchClinics();
  }

  // Fetch clinics based on the doctorId
  Future<void> fetchClinics() async {
    if (doctorId.value == null) {
      log("Doctor ID is not available");
      return;
    }

    try {
      final response =
          await DioHandler.dioGET(endpoint: "clinic/doctor/${doctorId.value}");
      if (response != null && response["clinics"] != null) {
        // Update the reactive list with the fetched data
        clinics.value = List<Map<String, dynamic>>.from(response["clinics"]);
      } else {
        clinics.clear();
        log('No clinics found in the response.');
      }
    } catch (e) {
      log("Error fetching clinics: $e");
      clinics.clear();
    }
  }

  void clearclinic() {
    clinics.clear(); // Clear clinic list
    selectedClinic.value = null; // Reset selected clinic
    selectedClinicId.value = null; // Reset selected clinic ID
  }
}
