// ignore_for_file: implementation_imports

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/cupertino/activity_indicator.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/controller/clinic_controller.dart';
import 'package:smile_x_doctor_app/controller/patient_list_controller.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';
import 'package:smile_x_doctor_app/utils/const.dart';

class Apputili {
  //textfield
  Widget buildTextField({
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
    TextEditingController? controller,
    IconData? prefixIcon, // Make the prefixIcon optional
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
    String? text, // Optional text
    IconData? icon,
    CupertinoActivityIndicator? child, // Optional icon
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
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
            if (icon != null) // If icon is provided, display it
              Icon(
                icon,
                color: AppColors.primary,
              ),
            if (text != null) // If text is provided, display it
              SizedBox(
                  width: icon != null
                      ? 10
                      : 0), // Add spacing between icon and text if both are provided
            if (text != null) // Show the text if provided
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
      log('Selected clinic: ${controller.selectedClinic.value}');
      return SizedBox(
        width: double.infinity,
        child: DropdownButtonFormField<Map<String, dynamic>>(
          value: controller.selectedClinic.value,
          isExpanded: true,
          onChanged: (clinic) {
            log('Selected clinic in onChanged: $clinic');
            if (clinic != null) {
              controller.selectedClinic(clinic);
              final clinicId = clinic['clinic_id'];
              if (clinicId != null) {
                patientsController.fetchPatients(clinicId);
              }
            }
          },
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: AppColors.black,
                    size: screenHeight * 0.03,
                  )
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
          items: controller.clinics.map((clinic) {
            return DropdownMenuItem<Map<String, dynamic>>(
              value: clinic,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    child: Text(
                      clinic["clinic_name"],
                      style: GoogleFonts.poppins(
                        fontSize: screenHeight1 * 1.8,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
