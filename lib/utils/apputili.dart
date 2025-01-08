import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    IconData? icon, // Optional icon
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
}
