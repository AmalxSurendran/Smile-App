import 'dart:developer';
import 'package:get/get.dart';
import 'package:smile_x_doctor_app/utils/dio_handler.dart';

class AppointmentsController extends GetxController {
  var appointments = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var doctorId = Rx<String?>(null);

  // Set the doctor ID (for example, from login)
  void setDoctorId(String doctorId) {
    this.doctorId.value = doctorId;
    log('DoctorId.valu3: $doctorId');
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      isLoading.value = true;

      // Prepare parameters to send with the request
      Map<String, dynamic> params = {'id': doctorId.value};

      // Fetch the appointments with doctor_id as a parameter
      final response = await DioHandler.dioPOST(
          endpoint: 'appointments/listing', params: params);

      // Ensure the response contains the appointments list
      if (response != null && response['appointments'] is List) {
        final appointmentsList = response['appointments'] as List;

        if (appointmentsList.isNotEmpty) {
          // Clear existing appointments to prevent duplication
          appointments.clear();

          // Use a map to store unique appointments by appointment_id
          final Map<int, Map<String, dynamic>> uniqueAppointments = {};

          for (var appointment in appointmentsList) {
            // Use appointment_id as the key to ensure uniqueness
            final appointmentId = appointment['id'] as int;

            // Only add the appointment if it doesn't already exist in the map
            if (!uniqueAppointments.containsKey(appointmentId)) {
              uniqueAppointments[appointmentId] =
                  appointment as Map<String, dynamic>;
            }
          }

          // Add the unique appointments to the list
          appointments.addAll(uniqueAppointments.values);
        } else {
          log('Appointments list is empty.');
        }
      } else {
        log('No appointments found or invalid response');
      }
    } catch (e) {
      log('Error fetching appointments: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Method to clear the appointments when logging out
  void clearAppointments() {
    appointments.clear();
    doctorId.value = null;
    isLoading.value = false;
    log('Appointments cleared on logout');
    update(); // Refresh the appointments
  }
}
