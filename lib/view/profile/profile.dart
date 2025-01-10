// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/controller/profile_controller.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';
import 'package:smile_x_doctor_app/utils/const.dart';
import 'package:smile_x_doctor_app/utils/routes/app_routes.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontSize: screenHeight * 0.027,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Obx(() {
              if (controller.doctorDetailsList.isEmpty) {
                return const Center(child: CupertinoActivityIndicator());
              }

              return controller.doctorDetailsList.length > 3
                  ? Text(
                      controller.doctorDetailsList[3],
                      style: GoogleFonts.poppins(
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : const SizedBox(); // Fallback when data is not available yet
            }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kHeight(0.05),
            Obx(
              () => CircleAvatar(
                radius: screenWidth * 0.20,
                backgroundColor: Colors.blue,
                child: Text(
                  controller.doctorInitials.value,
                  style: GoogleFonts.poppins(
                      fontSize: screenHeight * 0.045,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),

            kHeight(0.03),
            // Use Obx to update UI when doctorDetailsList changes
            Obx(() {
              log('profile screen doctorDetailsList: ${controller.doctorDetailsList}');
              // If the list is empty, show a loading indicator
              if (controller.doctorDetailsList.isEmpty) {
                return const Center(child: CupertinoActivityIndicator());
              } else {
                // Display the fetched doctor details
                return Column(
                  children: [
                    Text(
                      "Dr. ${controller.doctorDetailsList[0]}", // Name
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      controller.doctorDetailsList[1], // Email
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                );
              }
            }),
            kHeight(0.025),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildProfileOption(
                    icon: Icons.person,
                    title: 'Account',
                    onTap: () {
                      Get.toNamed(AppRoutes.account);
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.local_hospital,
                    title: 'Create Clinic',
                    onTap: () {
                      Get.toNamed(AppRoutes.AddClinic);
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    onTap: () {},
                  ),
                  _buildProfileOption(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {},
                  ),
                  _buildProfileOption(
                    icon: Icons.help,
                    title: 'Help & Support',
                    onTap: () {},
                  ),
                  _buildProfileOption(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Logout',
                              style: GoogleFonts.poppins(
                                fontSize: screenHeight * 0.03,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                            ),
                            content: Text(
                              "Are you sure you want to logout?",
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
                                  onPressed: () => Get.back(),
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
                                  onPressed: () => Get.offNamed("/login"),
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
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
    );
  }
}
