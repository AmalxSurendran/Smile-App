// ignore_for_file: non_constant_identifier_names, deprecated_member_use, unnecessary_null_comparison

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/controller/appointment_list.dart';
import 'package:smile_x_doctor_app/controller/clinic_controller.dart';
import 'package:smile_x_doctor_app/controller/home_controller.dart';
import 'package:smile_x_doctor_app/controller/patient_add_controller.dart';
import 'package:smile_x_doctor_app/controller/patient_list_controller.dart';
import 'package:smile_x_doctor_app/controller/profile_controller.dart';
import 'package:smile_x_doctor_app/utils/apputili.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';
import 'package:smile_x_doctor_app/utils/routes/app_routes.dart';
import 'package:smile_x_doctor_app/utils/shared_preference.dart';
import '../utils/const.dart';
import '../utils/custom_text_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Controllers initialized once
  final HomeController controller = Get.put(HomeController());
  final Profilecontroller = Get.put(ProfileController());
  final ClinicController clinicController = Get.put(ClinicController());
  final Pcontroller = Get.put(PatientsListController());
  final acontroller = Get.put(AppointmentsController());
  final Pacontroller = Get.put(PatientAddController());
  @override
  Widget build(BuildContext context) {
    final doctorDetails = SharedPreferencesService.loadDoctorDetails();

    // Check if selected clinic is null, and if so, re-fetch or reset

    return WillPopScope(
      onWillPop: () async {
        return await controller.showExitConfirmationDialog(context);
      },
      child: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            title: "Welcome Back!",
                            fontSize: screenHeight * 0.025,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondary,
                          ),
                          CustomTextWidget(
                              title: 'Welcome, Dr. ${doctorDetails?['name']}'),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.toNamed("/appointment");
                        },
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          color: AppColors.greyShade,
                        ),
                      ),
                      kWidth(0.05),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.profile);
                        },
                        child: CircleAvatar(
                          radius: screenWidth * 0.07,
                          backgroundColor: Colors.blue,
                          child: Text(
                            Profilecontroller.extractInitials(
                              doctorDetails != null
                                  ? doctorDetails['name'] ?? ''
                                  : 'xx',
                            ),
                            style: GoogleFonts.poppins(
                              fontSize: screenHeight * 0.02,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  kHeight(0.03),

                  Apputili().buildDropdown(
                    hintText: "Select Clinic",
                    controller: clinicController,
                    patientsController: Pcontroller,
                  ),

                  kHeight(0.03),
                  // Tab Bar Section
                  Container(
                    height: screenHeight * 0.07,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.contents),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TabBar(
                      labelPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth1,
                      ),
                      dividerColor: Colors.transparent,
                      padding: EdgeInsets.all(screenWidth2),
                      onTap: (index) {
                        controller.currentIndex.value = index;
                      },
                      indicator: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      unselectedLabelColor: AppColors.contents,
                      labelColor: AppColors.primary,
                      tabs: [
                        buildTab(0, "Patients"),
                        buildTab(1, "Appointments"),
                      ],
                    ),
                  ),
                  kHeight(0.02),
                  // Recently Viewed Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomTextWidget(
                        title: "Recently Viewed",
                        fontWeight: FontWeight.w500,
                      ),
                      InkWell(
                        onTap: () {
                          // Check if clinicIdFromLogin is empty
                          if (Pacontroller.clinicIdFromLogin.value.isEmpty) {
                            // Show a snackbar to prompt the user to select a clinic
                            Get.snackbar(
                              "Select Clinic", // Title of the Snackbar
                              "Please select a clinic to add patients", // Message
                              backgroundColor:
                                  Colors.red, // Snackbar background color
                              colorText:
                                  Colors.white, // Text color for the Snackbar
                              duration: const Duration(
                                  seconds:
                                      3), // Duration the snackbar is visible
                            );
                          } else {
                            // Proceed to the case submission page
                            if (kDebugMode) {
                              print(
                                  'selected index inkwell : ${Pacontroller.clinicIdFromLogin.value}');
                            }
                            // Get.toNamed("/caseSubmission");
                            Apputili().showBottomSheet(context);
                          }
                        },
                        child: Row(
                          children: [
                            const CustomTextWidget(
                              title: "Add",
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                            kWidth(0.01),
                            const Icon(
                              Icons.person_add_alt_1_rounded,
                              color: AppColors.secondary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  kHeight(0.01),
                  // Tab Content
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildPatientListView(),
                        _buildAppointmentListView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to build ListView for Patients
  Widget _buildPatientListView() {
    return Obx(() {
      if (Pcontroller.isLoading.value) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if (Pcontroller.patients.isEmpty) {
        return const Center(
          child: Text(
            'No patients found.',
            style: TextStyle(fontSize: 18, color: AppColors.greyShade),
          ),
        );
      }
      return ListView.builder(
        itemCount: Pcontroller.patients.length,
        itemBuilder: (context, index) {
          final patient = Pcontroller.patients[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
            padding: EdgeInsets.all(screenHeight1),
            decoration: BoxDecoration(
              color: AppColors.homeCard,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.lightGray,
                  onBackgroundImageError: (_, __) {
                    const AssetImage("assets/images/splash.jpeg");
                  },
                  backgroundImage: NetworkImage(
                    'https://ui-avatars.com/api/?name=${patient['patient_name']}&background=random&color=fff&size=128',
                  ),
                  radius: screenWidth8,
                ),
                kWidth(0.02),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(title: patient['patient_name']),
                      CustomTextWidget(title: patient['phone_number']),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.greyShade,
                ),
              ],
            ),
          );
        },
      );
    });
  }

  // Function to build ListView for Appointments
  Widget _buildAppointmentListView() {
    return Obx(() {
      if (acontroller.isLoading.value) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }

      // Check if there are valid appointments
      if (acontroller.appointments.isEmpty ||
          !acontroller.appointments.any((appointment) {
            // Validate if the patient exists and if appointment time is available
            bool isValid = appointment['patient_name']?.isNotEmpty == true &&
                appointment['appointment_time']?.isNotEmpty == true;

            // Log if the appointment passes the validation or not
            log('Appointment is valid: $isValid');

            return isValid;
          })) {
        // If no valid appointments, show "No appointments found"
        return const Center(
          child: Text(
            'No appointments found.',
            style: TextStyle(fontSize: 18, color: AppColors.greyShade),
          ),
        );
      }

      // Render the list of valid appointments
      return ListView.builder(
        itemCount: acontroller.appointments.length,
        itemBuilder: (context, index) {
          final appointment = acontroller.appointments[index];

          // Log for debugging appointment data
          log('Appointment: $appointment');

          // Skip rendering if the appointment is invalid
          if (appointment['patient_name'] == null ||
              appointment['patient_name'].isEmpty ||
              appointment['appointment_time'] == null ||
              appointment['appointment_time'].isEmpty) {
            return const SizedBox.shrink(); // Skip invalid data
          }

          // Proceed to render valid appointment data
          return Container(
            margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
            padding: EdgeInsets.all(screenHeight1),
            decoration: BoxDecoration(
              color: AppColors.homeCard,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                // Display patient's avatar using patient_name
                CircleAvatar(
                  backgroundColor: AppColors.lightGray,
                  onBackgroundImageError: (_, __) {
                    const AssetImage("assets/images/splash.jpeg");
                  },
                  backgroundImage: NetworkImage(
                    'https://ui-avatars.com/api/?name=${appointment['patient_name']}&background=random&color=fff&size=128',
                  ),
                  radius: screenWidth8,
                ),
                kWidth(0.02),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(title: appointment['patient_name']),
                      CustomTextWidget(title: appointment['appointment_time']),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.greyShade,
                ),
              ],
            ),
          );
        },
      );
    });
  }

  // Function to build a tab for the TabBar
  Obx buildTab(int index, String title) {
    return Obx(
      () {
        return Tab(
          child: SizedBox(
            width: screenWidth / 3,
            height: screenHeight * 0.07,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: controller.currentIndex.value == index
                    ? AppColors.secondary
                    : AppColors.homeCard,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomTextWidget(
                title: title,
                color: controller.currentIndex.value == index
                    ? AppColors.primary
                    : AppColors.contents,
                fontSize: screenHeight * 0.018,
              ),
            ),
          ),
        );
      },
    );
  }
}
