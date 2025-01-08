// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x_doctor_app/controller/home_controller.dart';
import 'package:smile_x_doctor_app/controller/profile_controller.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';
import 'package:smile_x_doctor_app/utils/routes/app_routes.dart';
import '../utils/const.dart';
import '../utils/custom_text_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController controller = Get.put(HomeController());
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

  // Function to generate dummy data with random Malayalam names and custom image URLs based on names
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
            "image": imageUrl,
          };
        case 'appointments':
          return {
            "name": randomName,
            "appointmentDate": "23.Dec.2024",
            "timeAgo": "${(index + 1) * 5} min ago",
            "image": imageUrl,
          };
        case 'caseSubmit':
          return {
            "name": randomName,
            "phone": "98987678${index + 1}",
            "image": imageUrl,
          };
        default:
          return {};
      }
    });
  }

  // Function to generate a unique image URL based on the name (for demo purposes)
  String _generateImageUrl(String name) {
    // Here we generate an avatar or image based on the initials of the name
    final initials = name.split(" ").map((word) => word[0]).take(2).join();
    return 'https://ui-avatars.com/api/?name=$initials&background=random&color=fff&size=128'; // Custom avatar URL
  }

  @override
  Widget build(BuildContext context) {
    // Generate dummy data
    final patientsData = generateDummyData(malayaliNames, 'patients');
    final appointmentsData = generateDummyData(malayaliNames, 'appointments');
    final caseSubmitData = generateDummyData(malayaliNames, 'caseSubmit');
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        bool shouldPop = await controller.showExitConfirmationDialog(context);
        return shouldPop;
      },
      child: DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                top: screenHeight * 0.05,
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
                          const CustomTextWidget(
                            title: "Dr. Nisha Paul",
                          ),
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
                          final pcontroller = Get.put(ProfileController());
                          pcontroller.fetchProfile('DR1001');
                          Get.toNamed(AppRoutes.profile);
                          // Show a dialog when the avatar is tapped
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return AlertDialog(
                          //       title: const Text("Logout"),
                          //       content: const Text(
                          //           "Are you sure you want to logout?"),
                          //       actions: [
                          //         TextButton(
                          //           onPressed: () {
                          //             Navigator.pop(
                          //                 context); // Close the dialog
                          //           },
                          //           child:
                          //               const CustomTextWidget(title: "Cancel"),
                          //         ),
                          //         TextButton(
                          //           onPressed: () {
                          //             // Perform logout operation here
                          //             Get.offNamed("/login");
                          //             // Add logout logic here
                          //           },
                          //           child:
                          //               const CustomTextWidget(title: "Logout"),
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.lightGray,
                          radius: screenWidth8,
                          backgroundImage:
                              const AssetImage("assets/images/splash.jpeg"),
                        ),
                      )
                    ],
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
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: screenWidth1),
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
                        buildTab(2, "Case Submit"),
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
                        // Tab 1 Content: Patients List
                        _buildListView(
                          patientsData,
                          (item) => [
                            CustomTextWidget(title: item["name"]!),
                            CustomTextWidget(title: item["phone"]!),
                          ],
                        ),
                        // Tab 2 Content: Appointments List
                        _buildListView(
                          appointmentsData,
                          (item) => [
                            CustomTextWidget(title: item["name"]!),
                            CustomTextWidget(title: item["appointmentDate"]!),
                            CustomTextWidget(title: item["timeAgo"]!),
                          ],
                        ),
                        // Tab 3 Content: Case Submit List
                        _buildListView(
                          caseSubmitData,
                          (item) => [
                            CustomTextWidget(title: item["name"]!),
                            CustomTextWidget(title: item["phone"]!),
                          ],
                        ),
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
  ListView _buildListView(
    List<Map<String, String>> data,
    List<Widget> Function(Map<String, String> item) itemBuilder,
  ) {
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
              // Display image
              CircleAvatar(
                backgroundColor: AppColors.lightGray,
                onBackgroundImageError: (_, __) {
                  // Fallback to local image in case of error
                  const AssetImage("assets/images/splash.jpeg");
                },
                backgroundImage:
                    item["image"] != null && item["image"]!.isNotEmpty
                        ? NetworkImage(
                            item["image"]!) // Use network image if available
                        : const AssetImage("assets/images/splash.jpeg"),
                radius: screenWidth8, // Adjust size as needed
              ),
              kWidth(0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: itemBuilder(item),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.contents,
              ),
            ],
          ),
        );
      },
    );
  }

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
                fontSize: screenHeight * 0.014,
              ),
            ),
          ),
        );
      },
    );
  }
}
