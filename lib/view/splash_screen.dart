import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../utils/colors.dart';
import '../utils/const.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/images/splash_nw.json'),
              kHeight(0.02),
              Image.asset(
                'assets/images/xlogo.png.pagespeed.ic.5Ym489GxiS.webp',
                width: screenWidth * 0.6,
                height: screenHeight * 0.15,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
