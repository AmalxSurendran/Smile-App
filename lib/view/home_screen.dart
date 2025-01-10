// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/controller/clinic_controller.dart';
import 'package:smile_x_doctor_app/controller/home_controller.dart';
import 'package:smile_x_doctor_app/controller/patient_list_controller.dart';
import 'package:smile_x_doctor_app/controller/profile_controller.dart';
import 'package:smile_x_doctor_app/utils/apputili.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';
import 'package:smile_x_doctor_app/utils/routes/app_routes.dart';
import '../utils/const.dart';
import '../utils/custom_text_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Controllers initialized once
  final HomeController controller = Get.put(HomeController());
  final ProfileController profileController = Get.put(ProfileController());
  final ClinicController clinicController = Get.put(ClinicController());
  final Pcontroller = Get.put(PatientsListController());
  // List of common Malayalam names
  final List<String> malayaliNames = [
    "Ajay Kumar",
    "Anu Joseph",
    "Biju Ramesh",
    "Lekha Nair",
    "Vishnu Suresh",
    "Sreeja Menon",
    "Ravi Kumar",
    "Geethu Radhakrishnan",
    "Arun Raj",
    "Sindhu Rajan"
  ];

  // Function to generate dummy data with random Malayalam names and custom image URLs
  List<Map<String, String>> generateDummyData(
      List<String> nameList, String type) {
    final random = Random();
    return List.generate(10, (index) {
      final randomName = nameList[random.nextInt(nameList.length)];
      final imageUrl =
          _generateImageUrl(randomName); // Generate image URL based on name
      switch (type) {
        case 'patients':
          return {
            "name": randomName,
            "phone": "98987678${index + 1}",
            "image": imageUrl
          };
        case 'appointments':
          return {
            "name": randomName,
            "appointmentDate": "23.Dec.2024",
            "timeAgo": "${(index + 1) * 5} min ago",
            "image": imageUrl
          };

        default:
          return {};
      }
    });
  }

  // Function to generate a unique image URL based on the name
  String _generateImageUrl(String name) {
    final initials = name.split(" ").map((word) => word[0]).take(2).join();
    return 'https://ui-avatars.com/api/?name=$initials&background=random&color=fff&size=128'; // Custom avatar URL
  }

  @override
  Widget build(BuildContext context) {
    final doctorDetailsList = Get.arguments as List<String>? ?? [];

    if (doctorDetailsList.isNotEmpty &&
        profileController.doctorInitials.value.isEmpty) {
      profileController.fetchProfile(doctorDetailsList[0]);
    }

    // Generate dummy data
    final patientsData = generateDummyData(malayaliNames, 'patients');
    final appointmentsData = generateDummyData(malayaliNames, 'appointments');

    return WillPopScope(
      onWillPop: () async {
        return await controller.showExitConfirmationDialog(context);
      },
      child: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            title: "Welcome Back!",
                            fontSize: screenHeight * 0.025,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondary,
                          ),
                          doctorDetailsList.isEmpty
                              ? const Text('No doctor details found')
                              : CustomTextWidget(
                                  title:
                                      'Welcome, Dr. ${doctorDetailsList[1]}'),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.toNamed("/appointment");
                        },
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          color: AppColors.greyShade,
                        ),
                      ),
                      kWidth(0.05),
                      GestureDetector(
                        onTap: () {
                          profileController.fetchProfile(doctorDetailsList[0]);
                          Get.toNamed(AppRoutes.profile);
                        },
                        child: Obx(() {
                          return CircleAvatar(
                            radius: screenWidth * 0.07,
                            backgroundColor: Colors.blue,
                            child: Text(
                              profileController.doctorInitials.value.isEmpty
                                  ? 'XX'
                                  : profileController.doctorInitials.value,
                              style: GoogleFonts.poppins(
                                fontSize: screenHeight * 0.02,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  kHeight(0.03),
                  Apputili().buildDropdown(
                    hintText: "Select Clinic",
                    controller: clinicController,
                    patientsController: Pcontroller,
                  ),
                  kHeight(0.03),
                  // Tab Bar Section
                  Container(
                    height: screenHeight * 0.07,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.contents),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TabBar(
                      labelPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth1,
                      ),
                      dividerColor: Colors.transparent,
                      padding: EdgeInsets.all(screenWidth2),
                      onTap: (index) {
                        controller.currentIndex.value = index;
                      },
                      indicator: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      unselectedLabelColor: AppColors.contents,
                      labelColor: AppColors.primary,
                      tabs: [
                        buildTab(0, "Patients"),
                        buildTab(1, "Appointments"),
                      ],
                    ),
                  ),
                  kHeight(0.02),
                  // Recently Viewed Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomTextWidget(
                        title: "Recently Viewed",
                        fontWeight: FontWeight.w500,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed("/caseSubmission");
                        },
                        child: Row(
                          children: [
                            const CustomTextWidget(
                              title: "Add",
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                            kWidth(0.01),
                            const Icon(
                              Icons.person_add_alt_1_rounded,
                              color: AppColors.secondary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  kHeight(0.01),
                  // Tab Content
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildListView(
                            patientsData,
                            (item) => [
                                  CustomTextWidget(title: item["name"]!),
                                  CustomTextWidget(title: item["phone"]!),
                                ]),
                        _buildListView(
                            appointmentsData,
                            (item) => [
                                  CustomTextWidget(title: item["name"]!),
                                  CustomTextWidget(
                                      title: item["appointmentDate"]!),
                                  CustomTextWidget(title: item["timeAgo"]!),
                                ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to build ListView for a tab
  ListView _buildListView(List<Map<String, String>> data,
      List<Widget> Function(Map<String, String> item) itemBuilder) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
          padding: EdgeInsets.all(screenHeight1),
          decoration: BoxDecoration(
            color: AppColors.homeCard,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.lightGray,
                onBackgroundImageError: (_, __) {
                  const AssetImage("assets/images/splash.jpeg");
                },
                backgroundImage:
                    item["image"] != null && item["image"]!.isNotEmpty
                        ? NetworkImage(item["image"]!)
                        : const AssetImage("assets/images/splash.jpeg"),
                radius: screenWidth8,
              ),
              kWidth(0.02),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: itemBuilder(item))),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.greyShade,
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to build a tab for the TabBar
  Obx buildTab(int index, String title) {
    return Obx(
      () {
        return Tab(
          child: SizedBox(
            width: screenWidth / 3,
            height: screenHeight * 0.07,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: controller.currentIndex.value == index
                    ? AppColors.secondary
                    : AppColors.homeCard,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomTextWidget(
                title: title,
                color: controller.currentIndex.value == index
                    ? AppColors.primary
                    : AppColors.contents,
                fontSize: screenHeight * 0.018,
              ),
            ),
          ),
        );
      },
    );
  }
}
