import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/controller/authentication/signup_controller.dart';
import 'package:smile_x_doctor_app/utils/apputili.dart';
import '../../utils/colors.dart';
import '../../utils/const.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using GetX to manage password visibility state
    final controller = Get.put(SignupController());

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth7, vertical: screenHeight3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/xlogo.png.pagespeed.ic.5Ym489GxiS.webp',
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.15,
                    fit: BoxFit.contain,
                  ),
                  // Title "Welcome"
                  Column(
                    children: [
                      Text(
                        'Welcome',
                        style: GoogleFonts.aBeeZee(
                          fontSize: screenHeight3,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Register your account',
                        style: GoogleFonts.poppins(
                          fontSize: screenHeight * 0.018,
                          fontWeight: FontWeight.w400,
                          color: AppColors.darkGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      kHeight(0.03),
                      Apputili().buildTextField(
                        hintText: 'Enter your name',
                        prefixIcon: Icons.email_outlined,
                        controller: controller.namecontroller,
                      ),
                      kHeight(0.01),
                      Apputili().buildTextField(
                        hintText: 'Enter your email',
                        prefixIcon: Icons.email_outlined,
                        controller: controller.emailcontroller,
                      ),
                      kHeight(0.01),
                      Apputili().buildTextField(
                        hintText: 'Enter your Mobile Number',
                        prefixIcon: Icons.email_outlined,
                        controller: controller.phonecontroller,
                      ),
                      kHeight(0.01),
                      Apputili().buildTextField(
                        hintText: 'Enter your username',
                        prefixIcon: Icons.person_2_outlined,
                        controller: controller.usernamecontroller,
                      ),
                      kHeight(0.01),
                      Obx(
                        () => Apputili().buildTextField(
                          hintText: 'Enter your password',
                          prefixIcon: Icons.lock_outline,
                          obscureText: controller.isPasswordHidden.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordHidden.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                          controller: controller.passwordcontroller,
                        ),
                      ),
                      kHeight(0.04),
                      Obx(() {
                        return Apputili().customButton(
                          onPressed: () async {
                            await controller.signUp();
                          },
                          text: 'Signup',
                          isLoading: controller.isLoading.value,
                        );
                      }),
                      kHeight(0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: GoogleFonts.poppins(
                              fontSize: screenHeight * 0.015,
                              fontWeight: FontWeight.w500,
                              color: AppColors.greyShade,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                fontSize: screenHeight * 0.022,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blueShade,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
