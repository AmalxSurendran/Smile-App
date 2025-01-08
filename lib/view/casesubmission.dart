import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';
import 'package:smile_x_doctor_app/utils/const.dart';

class CaseSubmission extends StatelessWidget {
  const CaseSubmission({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> options =
        List<String>.generate(100, (index) => (index + 1).toString());
    String? selectedValue;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal:
                    screenWidth6), // Replaced hardcoded padding with scaled value
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight(0.02),
                _buildTitle(context, title: 'Patient Names'),
                kHeight(0.01),
                _buildTextField('Enter patient name'),
                kHeight(0.01),
                _buildTitle(context, title: 'Patient Age'),
                kHeight(0.01),
                _buildDropdown(options, selectedValue),
                kHeight(0.01),
                _buildTitle(context, title: 'Chief Complaint'),
                kHeight(0.01),
                _buildComplaintContainer('Enter complaint'),
                kHeight(0.01),
                _buildTitle(context, title: 'Treatment Goals'),
                kHeight(0.01),
                _buildComplaintContainer('Enter treatment goals'),
                kHeight(0.01),
                _buildTitle(context, title: 'Upload Photos'),
                kHeight(0.02),
                _buildImageUpload(),
                kHeight(0.01),
                _buildTitle(context, title: 'Upload OPG'),
                kHeight(0.01),
                _buildTextField('Upload here'),
                kHeight(0.01),
                _buildTitle(context, title: 'Upload Documents'),
                kHeight(0.01),
                _buildTextField('Upload here'),
                kHeight(0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // AppBar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: _buildBackButton(),
      title: _buildTitle(context, title: 'Case Submission'),
      centerTitle: false,
      actions: [_buildProfileAvatar()],
    );
  }

  // Back button
  Widget _buildBackButton() {
    return Padding(
      padding: EdgeInsets.only(
          left: screenWidth6), // Replaced hardcoded padding with scaled value
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          height: screenWidth8,
          width: screenWidth8,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.lightGray,
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: screenHeight2, // Replaced hardcoded size with scaled value
          ),
        ),
      ),
    );
  }

  // Profile avatar
  Widget _buildProfileAvatar() {
    return Padding(
      padding: EdgeInsets.only(
          right: screenWidth6), // Replaced hardcoded padding with scaled value
      child: GestureDetector(
        onTap: () {},
        child: CircleAvatar(
          radius: screenWidth5, // Replaced hardcoded radius with scaled value
          backgroundImage: const AssetImage("assets/images/splash.jpeg"),
        ),
      ),
    );
  }

  // Title text widget
  Widget _buildTitle(BuildContext context,
      {required String title,
      double? fontSize,
      FontWeight? fontWeight,
      Color? color}) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: fontSize ??
                  screenHeight *
                      0.018, // Replaced hardcoded font size with scaled value
              fontWeight: fontWeight ?? FontWeight.w500,
              color: color ?? Colors.black,
            ),
      ),
    );
  }

  // TextField widget
  Widget _buildTextField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: screenHeight *
              0.016, // Replaced hardcoded font size with scaled value
          fontWeight: FontWeight.w400,
          color: AppColors.darkGray,
        ),
        filled: true,
        fillColor: AppColors.lightGray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              screenWidth5), // Replaced hardcoded value with scaled value
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: screenHeight *
              0.02, // Replaced hardcoded vertical padding with scaled value
          horizontal: screenWidth *
              0.05, // Replaced hardcoded horizontal padding with scaled value
        ),
      ),
    );
  }

  // Dropdown widget
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
            fontSize: screenHeight * 0.016, // Replaced with scaled value
            fontWeight: FontWeight.w400,
            color: AppColors.darkGray,
          ),
          filled: true,
          fillColor: AppColors.lightGray,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                screenWidth5), // Replaced with scaled value
            borderSide: BorderSide.none,
          ),
        ),
        dropdownColor: Colors.white,
        style: GoogleFonts.poppins(
          fontSize: screenHeight * 0.016, // Replaced with scaled value
          fontWeight: FontWeight.w400,
          color: AppColors.darkGray,
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.darkGray,
          size: screenHeight2, // Replaced with scaled value
        ),
        onChanged: (newValue) {
          selectedValue = newValue;
        },
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Center(
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: screenHeight * 0.016, // Replaced with scaled value
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkGray,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Complaint container widget
  Widget _buildComplaintContainer(String hintText) {
    return Container(
      height: screenHeight * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(screenWidth5)),
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
      ),
      child: TextField(
        maxLines: null,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: screenHeight * 0.016, // Scaled value
            fontWeight: FontWeight.w400,
            color: AppColors.darkGray,
          ),
          filled: true,
          fillColor: AppColors.lightGray,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth5), // Scaled value
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02, // Scaled value
            horizontal: screenWidth * 0.05, // Scaled value
          ),
        ),
      ),
    );
  }

  // Image upload container
  Widget _buildImageUpload() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(6, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth10 * 0.09), // Replaced with scaled value
            child: _buildImageContainer(),
          );
        }),
      ),
    );
  }

  // Image container widget
  Widget _buildImageContainer() {
    return Container(
      height: screenHeight10, // Replaced with scaled value
      width: screenWidth * 0.4, // Replaced with scaled value
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius:
            BorderRadius.circular(screenWidth5), // Replaced with scaled value
        border: Border.all(
          // ignore: deprecated_member_use
          color: AppColors.darkGray.withOpacity(0.1),
        ),
      ),
      child: const Icon(
        Icons.image_outlined,
        color: AppColors.darkGray,
      ),
    );
  }
}
