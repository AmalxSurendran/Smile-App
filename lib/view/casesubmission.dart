// ignore_for_file: non_constant_identifier_names, unused_element, deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/controller/patient_add_controller.dart';
import 'package:smile_x_doctor_app/controller/patient_list_controller.dart';
import 'package:smile_x_doctor_app/utils/apputili.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';
import 'package:smile_x_doctor_app/utils/const.dart';

class CaseSubmission extends StatelessWidget {
  const CaseSubmission({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PatientAddController());
    final Pcontroller = Get.put(PatientsListController());

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final List<String> ageOptions =
        List.generate(110, (index) => (index + 1).toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Case Submission',
          style: GoogleFonts.poppins(
            fontSize: screenHeight * 0.027,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(context, 'Patient Name'),
              kHeight(0.01),
              Apputili().buildTextField(
                hintText: 'Enter patient name',
                controller: controller.Pnamecontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),

              kHeight(0.02),
              // _buildSectionTitle(context, 'Patient Age'),
              // kHeight(0.01),
              // _buildDropdown(ageOptions, controller),
              // kHeight(0.02),
              // _buildSectionTitle(context, 'Patient Gender'),
              // kHeight(0.01),
              // _buildGenderRadioButtons(controller),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Patient Age Dropdown
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(context, 'Patient Age'),
                        kHeight(0.01),
                        _buildDropdown(ageOptions, controller),
                      ],
                    ),
                  ),

                  // Patient Gender Radio Buttons
                  Expanded(
                    child: Column(
                      children: [
                        _buildSectionTitle(context, 'Patient Gender'),
                        kHeight(0.01),
                        _buildGenderRadioButtons(controller),
                      ],
                    ),
                  ),
                ],
              ),
              kHeight(0.02),
              _buildSectionTitle(context, 'Patient Email'),
              kHeight(0.01),
              Apputili().buildTextField(
                hintText: 'Enter patient Email',
                controller: controller.Pemailcontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),

              kHeight(0.02),
              _buildSectionTitle(context, 'Patient Phone number'),
              kHeight(0.01),
              Apputili().buildTextField(
                hintText: 'Enter phone number',
                controller: controller.Pnumbercontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),

              kHeight(0.02),
              _buildSectionTitle(context, 'Patient Address'),
              kHeight(0.01),
              _buildLargeTextField(
                'Enter Patient Address',
                controller.Paddresscontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address cannot be empty';
                  }
                  return null;
                },
              ),

              kHeight(0.02),
              _buildSectionTitle(context, 'Chief Complaint'),
              kHeight(0.01),
              _buildLargeTextField(
                'Enter Chief Complaint',
                controller.Pcomplaintcontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a complaint';
                  }
                  return null;
                },
              ),

              kHeight(0.02),
              _buildSectionTitle(context, 'Treatment Goals'),
              kHeight(0.01),
              _buildLargeTextField(
                'Enter Treatment Goals',
                controller.Pgoalcontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter treatment goals';
                  }
                  return null;
                },
              ),
              kHeight(0.04),
              Obx(() {
                return Apputili().customButton(
                  // Pass the controller's isLoading value to the button
                  text: 'Save',
                  isLoading:
                      controller.isLoading.value, // Pass the isLoading value
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      // Start the loading indicator
                      await controller.createPatient();

                      // Get the clinic ID from the controller
                      final clinicId = controller.clinicIdFromLogin.value;

                      if (clinicId.isNotEmpty) {
                        await Pcontroller.fetchPatients(clinicId);

                        log('Fetched patients for clinic: $clinicId');
                      } else {
                        Get.snackbar("Error", "No clinic selected.");
                        return;
                      }

                      // Go back to the previous screen
                      Get.back();
                      controller.resetForm();
                    } else {
                      Get.snackbar(
                          "Error", "Please fill all fields correctly.");
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Section Title
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: screenHeight * 0.02,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
      ),
    );
  }

  // Dropdown Widget for Age
  Widget _buildDropdown(List<String> options, PatientAddController controller) {
    return Obx(() {
      return SizedBox(
        width: screenWidth10 * 3,
        height: screenHeight * 0.07,
        child: DropdownButtonFormField<String>(
          value: controller.selectedAge.value,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: 'Select Age',
            hintStyle: GoogleFonts.poppins(
              fontSize: screenHeight * 0.016,
              fontWeight: FontWeight.w400,
              color: AppColors.darkGray,
            ),
            filled: true,
            fillColor: AppColors.lightGray,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          dropdownColor: Colors.white,
          style: GoogleFonts.poppins(
            fontSize: screenHeight * 0.016,
            fontWeight: FontWeight.w400,
            color: AppColors.darkGray,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.darkGray,
            size: screenHeight2,
          ),
          onChanged: (newValue) {
            controller.selectedAge.value = newValue;
          },
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, textAlign: TextAlign.center),
            );
          }).toList(),
        ),
      );
    });
  }

  // Gender Radio Buttons (Male/Female)
  Widget _buildGenderRadioButtons(PatientAddController controller) {
    return Obx(
      () {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Male Option
            Center(
              child: Row(
                children: [
                  Radio<String>(
                    value: 'Male',
                    groupValue: controller.selectedGender.value,
                    onChanged: (value) {
                      controller.selectedGender.value = value!;
                    },
                  ),
                  Text(
                    'Male',
                    style: GoogleFonts.poppins(
                      fontSize: screenHeight * 0.016,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGray,
                    ),
                  ),
                ],
              ),
            ),
            // Female Option
            Row(
              children: [
                Radio<String>(
                  value: 'Female',
                  groupValue: controller.selectedGender.value,
                  onChanged: (value) {
                    controller.selectedGender.value = value!;
                  },
                ),
                Text(
                  'Female',
                  style: GoogleFonts.poppins(
                    fontSize: screenHeight * 0.016,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkGray,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Large Text Field Container
  Widget _buildLargeTextField(String hintText, controller,
      {required String? Function(dynamic value) validator}) {
    return Container(
      height: screenHeight * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(screenWidth5),
      ),
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
      ),
      child: Apputili().buildTextField(
          hintText: hintText, controller: controller, validator: validator),
    );
  }

  // Image Upload Row
  Widget _buildImageUploadRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(6, (index) {
          return Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.02, // Padding on the left
              right: index == 5
                  ? 0
                  : screenWidth * 0.02, // No right padding for the last item
            ),
            child: _buildImageContainer(),
          );
        }),
      ),
    );
  }

  // Image Container
  Widget _buildImageContainer() {
    return Container(
      height: screenHeight * 0.16,
      width: screenWidth * 0.4,
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkGray.withOpacity(0.1)),
      ),
      child: const Icon(
        Icons.image_outlined,
        color: AppColors.darkGray,
      ),
    );
  }

  // Upload Container
  Widget _buildUploadContainer({required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: screenHeight * 0.16,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(screenWidth5),
        ),
        child: Center(
          child: Icon(
            icon,
            size: screenHeight * 0.05,
            color: AppColors.greyShade.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
