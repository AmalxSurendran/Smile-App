import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/utils/apputili.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';
import 'package:smile_x_doctor_app/utils/const.dart';

class CaseSubmission extends StatelessWidget {
  const CaseSubmission({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> ageOptions =
        List.generate(100, (index) => (index + 1).toString());
    String? selectedAge;

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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Patient Name'),
            kHeight(0.01),
            Apputili().buildTextField(hintText: 'Enter patient name'),
            kHeight(0.02),
            _buildSectionTitle(context, 'Patient Age'),
            kHeight(0.01),
            _buildDropdown(ageOptions, selectedAge),
            kHeight(0.02),
            _buildSectionTitle(context, 'Chief Complaint'),
            kHeight(0.01),
            _buildLargeTextField('Enter Chief Complaint'),
            kHeight(0.02),
            _buildSectionTitle(context, 'Treatment Goals'),
            kHeight(0.01),
            _buildLargeTextField('Enter Treatment Goals'),
            kHeight(0.02),
            _buildSectionTitle(context, 'Upload Photos'),
            kHeight(0.01),
            _buildImageUploadRow(),
            kHeight(0.02),
            _buildSectionTitle(context, 'Upload OPG'),
            kHeight(0.01),
            _buildUploadContainer(icon: Icons.upload_file_outlined),
            kHeight(0.02),
            _buildSectionTitle(context, 'Upload Documents'),
            kHeight(0.01),
            _buildUploadContainer(icon: Icons.upload_file_outlined),
            kHeight(0.04),
            Apputili().customButton(
              text: 'Save',
              onPressed: () {
                // Implement save functionality
              },
            ),
          ],
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

  // Dropdown Widget
  Widget _buildDropdown(List<String> options, String? selectedValue) {
    return SizedBox(
      width: screenWidth10 * 3,
      height: screenHeight * 0.07,
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        isExpanded: true,
        decoration: InputDecoration(
          hintText: 'Age',
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
          selectedValue = newValue;
        },
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, textAlign: TextAlign.center),
          );
        }).toList(),
      ),
    );
  }

  // Large Text Field Container
  Widget _buildLargeTextField(String hintText) {
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
      child: Apputili().buildTextField(hintText: hintText),
    );
  }

  // Image Upload Row
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
