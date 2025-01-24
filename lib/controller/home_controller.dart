// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/controller/clinic_controller.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';
import 'package:smile_x_doctor_app/utils/const.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    Get.lazyPut(() => ClinicController());
  }

  Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await Get.dialog(
          AlertDialog(
            title: Text(
              'Exit',
              style: GoogleFonts.poppins(
                fontSize: screenHeight * 0.03,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            content: Text(
              'Do you really want to exit the app?',
              style: GoogleFonts.poppins(
                fontSize: screenHeight * 0.02,
                fontWeight: FontWeight.w400,
                color: AppColors.black.withOpacity(.7),
              ),
            ),
            actions: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () => Get.back(result: false),
                  child: Text(
                    'No',
                    style: GoogleFonts.poppins(
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () => Get.back(result: true),
                  child: Text(
                    'Yes',
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
        ) ??
        false;
  }
}
