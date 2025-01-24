// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/controller/authentication/login_controller.dart';
import 'package:smile_x_doctor_app/controller/profile_controller.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';
import 'package:smile_x_doctor_app/utils/const.dart';
import 'package:smile_x_doctor_app/utils/routes/app_routes.dart';
import 'package:smile_x_doctor_app/utils/shared_preference.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final doctorDetails = SharedPreferencesService.loadDoctorDetails();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontSize: screenHeight * 0.027,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kHeight(0.05),
            CircleAvatar(
              radius: screenWidth * 0.20,
              backgroundColor: Colors.blue,
              child: Text(
                controller.extractInitials(doctorDetails?['name'] ?? 'XX'),
                style: GoogleFonts.poppins(
                    fontSize: screenHeight * 0.045,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            kHeight(0.03),
            Column(
              children: [
                Text(
                  "Dr. ${doctorDetails?['name']}", // Name
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${doctorDetails?['email']}", // Email
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // Additional doctor details if needed
              ],
            ),
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
                                  onPressed: () {
                                    Get.back();
                                  },
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
                                  onPressed: () {
                                    final Logincontroller =
                                        Get.put(LoginController());
                                    Logincontroller.logout();
                                  },
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

// final doctorDetails = SharedPreferencesService.loadDoctorDetails();
// var name = doctorDetails?['name'];
