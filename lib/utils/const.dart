import 'package:flutter/material.dart';
import 'package:get/get.dart';

double get screenHeight => Get.height;
double get screenWidth => Get.width;

// Height multipliers
double screenHeightFactor(double factor) => screenHeight * factor;
double screenWidthFactor(double factor) => screenWidth * factor;

// Predefined screen height factors
double get screenHeight05 => screenHeightFactor(0.005);
double get screenHeight1 => screenHeightFactor(0.01);
double get screenHeight2 => screenHeightFactor(0.02);
double get screenHeight3 => screenHeightFactor(0.03);
double get screenHeight4 => screenHeightFactor(0.04);
double get screenHeight5 => screenHeightFactor(0.05);
double get screenHeight6 => screenHeightFactor(0.06);
double get screenHeight7 => screenHeightFactor(0.07);
double get screenHeight8 => screenHeightFactor(0.08);
double get screenHeight9 => screenHeightFactor(0.09);
double get screenHeight10 => screenHeightFactor(0.10);

// Predefined screen width factors
double get screenWidth1 => screenWidthFactor(0.01);
double get screenWidth2 => screenWidthFactor(0.02);
double get screenWidth3 => screenWidthFactor(0.03);
double get screenWidth4 => screenWidthFactor(0.04);
double get screenWidth5 => screenWidthFactor(0.05);
double get screenWidth6 => screenWidthFactor(0.06);
double get screenWidth7 => screenWidthFactor(0.07);
double get screenWidth8 => screenWidthFactor(0.08);
double get screenWidth9 => screenWidthFactor(0.09);
double get screenWidth10 => screenWidthFactor(0.10);
double get screenWidth35 => screenWidthFactor(0.35);

// SizedBox utilities for spacing
SizedBox kHeight(double factor) => SizedBox(height: screenHeightFactor(factor));
SizedBox kWidth(double factor) => SizedBox(width: screenWidthFactor(factor));
