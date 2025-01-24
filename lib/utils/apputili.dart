// ignore_for_file: implementation_imports, unnecessary_to_list_in_spreads, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/cupertino/activity_indicator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/controller/clinic_controller.dart';
import 'package:smile_x_doctor_app/controller/patient_add_controller.dart';
import 'package:smile_x_doctor_app/controller/patient_list_controller.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';
import 'package:smile_x_doctor_app/utils/const.dart';
import 'package:smile_x_doctor_app/utils/custom_text_widget.dart';
import 'package:smile_x_doctor_app/utils/routes/app_routes.dart';

class Apputili {
  //textfield
  Widget buildTextField({
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
    TextEditingController? controller,
    IconData? prefixIcon, // Make the prefixIcon optional
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          // Use the provided prefixIcon if available
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: AppColors.darkGray,
                  size: screenHeight * 0.018,
                )
              : null, // If no icon provided, use null
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: screenHeight * 0.018,
            fontWeight: FontWeight.w400,
            color: AppColors.darkGray,
          ),
          filled: true,
          fillColor: AppColors.lightGray,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: screenHeight2, horizontal: screenWidth2),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

//button
  Widget customButton({
    required VoidCallback onPressed,
    required String text,
    bool isLoading = false, // Add isLoading parameter
    IconData? icon,
    CupertinoActivityIndicator? child, // Optional icon or child widget
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed:
            isLoading ? null : onPressed, // Disable the button while loading
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const CupertinoActivityIndicator() // Show loading spinner if isLoading is true
            else if (icon != null)
              Icon(
                icon,
                color: AppColors.primary,
              ),
            if (text.isNotEmpty)
              SizedBox(
                width: icon != null && !isLoading ? 10 : 0,
              ),
            if (text.isNotEmpty && !isLoading)
              Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: screenHeight2,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown({
    required String hintText,
    required ClinicController controller,
    required PatientsListController patientsController,
    IconData? prefixIcon,
  }) {
    return Obx(() {
      final selectedClinic = controller.selectedClinic.value;
      final clinics = controller.clinics;
      final isLoading =
          clinics.isEmpty; // Assuming if clinics are empty, it's loading

      // Log the clinics data to check if it's being populated correctly

      if (clinics.isEmpty) {
        log('No clinics available.');
      }

      return SizedBox(
        width: double.infinity,
        child: isLoading
            ? const CupertinoActivityIndicator() // Show Cupertino spinner while loading
            : DropdownButtonFormField<String>(
                value: selectedClinic != null
                    ? selectedClinic['id'].toString()
                    : null, // Ensure null is passed if no clinic is selected
                isExpanded: true,
                onChanged: (clinicId) {
                  if (clinicId != null) {
                    log('Selected clinic ID: $clinicId');

                    if (clinicId == 'add_clinic') {
                      log('User wants to add a clinic');
                    } else {
                      final selectedClinic = controller.clinics.firstWhere(
                        (clinic) => clinic['id'].toString() == clinicId,
                        orElse: () => {},
                      );

                      if (selectedClinic.isNotEmpty) {
                        controller.selectedClinic.value = selectedClinic;
                        patientsController.fetchPatients(clinicId);
                        final addcontroller = Get.put(PatientAddController());
                        addcontroller.setclientId(clinicId);
                      } else {
                        log('Clinic not found for ID: $clinicId');
                      }
                    }
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: prefixIcon != null
                      ? Icon(prefixIcon,
                          color: AppColors.black, size: screenHeight * 0.03)
                      : null,
                  hintText: hintText,
                  hintStyle: GoogleFonts.poppins(
                    fontSize: screenHeight2,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                  filled: true,
                  fillColor: AppColors.lightGray,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight1, horizontal: screenWidth4),
                ),
                isDense: false,
                items: [
                  if (clinics.isNotEmpty)
                    ...clinics.map((clinic) {
                      return DropdownMenuItem<String>(
                        value: clinic['id'].toString(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          child: Text(
                            clinic['clinic_name'],
                            style: GoogleFonts.poppins(
                              fontSize: screenHeight1 * 1.8,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),

                  // Option to add a new clinic
                  DropdownMenuItem<String>(
                    value: 'add_clinic',
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.AddClinic);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        child: Row(
                          children: [
                            Icon(Icons.add,
                                color: AppColors.black,
                                size: screenHeight * 0.02),
                            const SizedBox(width: 10),
                            Text(
                              'Add Clinic',
                              style: GoogleFonts.poppins(
                                fontSize: screenHeight1 * 2,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // So it fits the content size
      backgroundColor: Colors.white, // Background color for the sheet
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(16)), // Rounded top corners
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: screenWidth * 0.1,
                height: screenHeight1 * 0.6,
                decoration: BoxDecoration(
                  color: Colors.grey, // Color of the handle line
                  borderRadius:
                      BorderRadius.circular(4), // Rounded corners for the line
                ),
              ),
              kHeight(0.03),
              ListTile(
                leading: const Icon(Icons.person),
                title: const CustomTextWidget(title: 'Add Patient'),
                onTap: () {
                  Get.toNamed(AppRoutes.caseSubmission)?.then((_) {
                    Get.back(); // Close the bottom sheet after navigation
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.healing),
                title: CustomTextWidget(title: 'Add Appointment'),
                onTap: () {
                  Get.toNamed(AppRoutes.AddAppointment)?.then((_) {
                    Get.back();
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.local_hospital),
                title: const CustomTextWidget(title: 'Add Consultation'),
                onTap: () {
                  Get.toNamed('/profile');
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                leading: const Icon(
                  Icons.cancel,
                  color: AppColors.danger,
                ),
                title: const CustomTextWidget(title: 'Cancel'),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
