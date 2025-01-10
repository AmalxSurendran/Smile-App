import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/utils/apputili.dart';
import 'package:smile_x_doctor_app/utils/routes/app_routes.dart';
import '../../utils/colors.dart';
import '../../utils/const.dart';
import '../../controller/authentication/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using GetX to manage password visibility state
    final LoginController loginController = Get.put(LoginController());

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth7, vertical: screenHeight3),
              child: Column(
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/xlogo.png.pagespeed.ic.5Ym489GxiS.webp',
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.15,
                    fit: BoxFit.contain,
                  ),
                  // Title "Welcome"

                  // Email or Mobile Input Field

                  Column(
                    children: [
                      Text(
                        'Welcome Back!',
                        style: GoogleFonts.aBeeZee(
                          fontSize: screenHeight3,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      kHeight(0.005),
                      Text(
                        'Login to your account',
                        style: GoogleFonts.poppins(
                          fontSize: screenHeight * 0.018,
                          fontWeight: FontWeight.w400,
                          color: AppColors.darkGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      kHeight(0.03),
                      // kHeight3,
                      Apputili().buildTextField(
                        hintText: 'Enter your email',
                        prefixIcon: Icons.email_outlined,
                        controller: loginController.emailcontroller,
                      ),

                      kHeight(0.01),
                      Obx(
                        () => Apputili().buildTextField(
                          hintText: 'Enter your password',
                          prefixIcon: Icons.lock_outline,
                          obscureText: loginController.isPasswordHidden.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              loginController.isPasswordHidden.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: loginController.togglePasswordVisibility,
                          ),
                          controller: loginController.passwordcontroller,
                        ),
                      ),
                    ],
                  ),
                  kHeight(0.005),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(
                          fontSize: screenHeight * 0.015,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blueShade,
                        ),
                      ),
                    ),
                  ),

                  kHeight(0.005),
                  Apputili().customButton(
                    onPressed: () {
                      loginController.login();
                    },
                    text: loginController.isLoading.value
                        ? '' // No text when loading
                        : 'Login', // Button text when not loading
                    child: loginController.isLoading.value
                        ? const CupertinoActivityIndicator() // Show activity indicator
                        : null, // No child when not loading
                  ),

                  kHeight(0.01),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't have an account?",
                        style: GoogleFonts.poppins(
                            fontSize: screenHeight * 0.015,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyShade),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.signup);
                        },
                        child: Text(
                          'SignUp',
                          style: GoogleFonts.poppins(
                              fontSize: screenHeight * 0.02,
                              fontWeight: FontWeight.w700,
                              color: AppColors.blueShade),
                        ),
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
