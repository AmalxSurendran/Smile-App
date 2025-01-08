import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/controller/profile_controller.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';
import 'package:smile_x_doctor_app/utils/const.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    // Fetch profile data when the screen is loaded
    controller
        .fetchProfile('doctorId'); // Pass doctorId as per your requirement

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
          style: GoogleFonts.poppins(
            fontSize: screenHeight * 0.027,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton.icon(
                icon: Icon(
                  controller.isEditing.value ? Icons.save : Icons.edit,
                  color: AppColors.black,
                ),
                label: Text(
                  controller.isEditing.value ? 'Save' : 'Edit',
                  style: GoogleFonts.poppins(
                      fontSize: screenHeight * 0.022,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyShade),
                ),
                onPressed: () {
                  controller.isEditing.value = !controller.isEditing.value;
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Obx(
              () => _buildTextField(
                controller: controller.nameController,
                label: 'Name',
                isEditing: controller.isEditing.value,
              ),
            ),
            SizedBox(height: 16),
            Obx(
              () => _buildTextField(
                controller: controller.mobileController,
                label: 'Mobile Number',
                isEditing: controller.isEditing.value,
              ),
            ),
            SizedBox(height: 16),
            // The email field is always read-only (fixed value)
            _buildTextField(
              controller: controller.emailController,
              label: 'Email',
              isEditing: false, // Ensure it's always non-editable
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool isEditing,
  }) {
    return TextField(
      style: GoogleFonts.poppins(
          fontSize: screenHeight * 0.017,
          fontWeight: FontWeight.w500,
          color: AppColors.greyShade),
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
      ),
      readOnly: !isEditing,
    );
  }
}
