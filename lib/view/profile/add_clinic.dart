import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/utils/apputili.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';
import 'package:smile_x_doctor_app/utils/const.dart';

class AddClinic extends StatelessWidget {
  const AddClinic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Clinic',
          style: GoogleFonts.poppins(
            fontSize: screenHeight * 0.027,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                ),
              ),
              kHeight(0.01),
              Apputili().buildTextField(hintText: 'Enter clinic name'),
              kHeight(0.02),
              Text(
                'Contact Number',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                ),
              ),
              kHeight(0.01),
              Apputili()
                  .buildTextField(hintText: 'Enter clinic contact number'),
              kHeight(0.02),
              Text(
                'Address',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                ),
              ),
              kHeight(0.01),
              Container(
                  height: screenHeight * 0.2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.lightGray,
                      borderRadius: BorderRadius.circular(screenWidth5)),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                  ),
                  child: Apputili()
                      .buildTextField(hintText: 'Enter clinic address')),
              kHeight(0.04),
              Apputili().customButton(
                text: 'Save Clinic',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
