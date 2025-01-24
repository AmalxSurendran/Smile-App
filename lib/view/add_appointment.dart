import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/utils/apputili.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';
import 'package:smile_x_doctor_app/utils/const.dart';

class AddAppointment extends StatelessWidget {
  const AddAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Appointment',
          style: GoogleFonts.poppins(
            fontSize: screenHeight * 0.027,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Patient Name',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: screenHeight * 0.02,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                  ),
                ),
                kHeight(0.01),
                Apputili().buildTextField(
                  hintText: 'Enter Patient name',
                ),
                kHeight(0.02),
                Text(
                  'Patient Number',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: screenHeight * 0.02,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                  ),
                ),
                kHeight(0.01),
                Apputili().buildTextField(
                  hintText: 'Enter Patient contact number',
                ),
                kHeight(0.02),
                Text(
                  'Patient Email Address',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: screenHeight * 0.02,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                  ),
                ),
                kHeight(0.01),
                Apputili().buildTextField(
                  hintText: 'Enter Patient Email Address',
                ),
                kHeight(0.02),
                Text(
                  'Patient Address',
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
                    borderRadius: BorderRadius.circular(screenWidth5),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                  ),
                  child: Apputili().buildTextField(
                    hintText: 'Enter Patient address',
                  ),
                ),
                kHeight(0.04),
                Apputili().customButton(
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                    } else {
                      // Show a message if form is invalid
                    }
                  },
                  text: 'Save',
                  // isLoading: controller.isLoading.value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
