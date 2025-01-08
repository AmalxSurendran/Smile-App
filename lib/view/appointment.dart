// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';
import 'package:smile_x_doctor_app/utils/const.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controller/appcontroller.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppointmentController controller = Get.put(AppointmentController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: _buildBackButton(),
        actions: [_buildProfileAvatar()],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight(0.02),
                _buildTitle(context),
                kHeight(0.02),
                _buildCalendar(controller, context),
                kHeight(0.02),
                _buildEditRow(context),
                kHeight(0.02),
                _buildAppointmentContainer(context),
                kHeight(0.02),
                _buildAppointmentContainer(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Back button widget
  Widget _buildBackButton() {
    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.06),
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          height: screenWidth5,
          width: screenWidth5,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.lightGray,
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: screenHeight2,
          ),
        ),
      ),
    );
  }

  // Profile avatar widget
  Widget _buildProfileAvatar() {
    return Padding(
      padding: EdgeInsets.only(right: screenWidth * 0.06),
      child: GestureDetector(
        onTap: () {},
        child: CircleAvatar(
          radius: screenWidth5,
          backgroundImage: const AssetImage("assets/images/splash.jpeg"),
        ),
      ),
    );
  }

  // Title text widget
  Widget _buildTitle(BuildContext context) {
    return Text(
      'Schedule Appointments',
      style: GoogleFonts.poppins(
        textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: screenHeight * 0.018,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  // Calendar widget
  Widget _buildCalendar(
      AppointmentController controller, BuildContext context) {
    String getMonthName(int month) {
      List<String> months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      return months[month - 1];
    }

    return Obx(
      () => Column(
        children: [
          _buildCalendarHeader(controller, getMonthName, context),
          _buildTableCalendar(controller),
        ],
      ),
    );
  }

  // Calendar header widget with navigation
  Widget _buildCalendarHeader(AppointmentController controller,
      String Function(int) getMonthName, BuildContext context) {
    return Container(
      height: screenWidth10,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.secondary,
            AppColors.blueShade,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: screenHeight2,
              color: AppColors.primary,
            ),
            onPressed: () {
              controller.updateSelectedDay(controller.selectedDay.value
                  .subtract(const Duration(days: 30)));
            },
          ),
          Center(
            child: Text(
              "${getMonthName(controller.selectedDay.value.month)} ${controller.selectedDay.value.year}",
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: screenHeight * 0.018,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              size: screenHeight2,
              color: AppColors.primary,
            ),
            onPressed: () {
              controller.updateSelectedDay(
                  controller.selectedDay.value.add(const Duration(days: 30)));
            },
          ),
        ],
      ),
    );
  }

  // Table calendar widget
  Widget _buildTableCalendar(AppointmentController controller) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(4.68),
          bottomRight: Radius.circular(4.68),
        ),
      ),
      child: TableCalendar(
        rowHeight: Get.height * 0.055,
        headerVisible: false,
        availableGestures: AvailableGestures.all,
        firstDay: DateTime.utc(2020, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: controller.selectedDay.value,
        selectedDayPredicate: (day) =>
            isSameDay(day, controller.selectedDay.value),
        onDaySelected: (day, focusedDay) {
          controller.updateSelectedDay(day);
        },
        onPageChanged: (focusedDay) {
          controller.updateSelectedDay(focusedDay);
        },
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            final text = controller.getWeekDayNamePublic(day);
            return Container(
              height: screenWidth10,
              width: screenWidth5,
              alignment: Alignment.center,
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: screenHeight * 0.012,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            );
          },
          defaultBuilder: (context, day, focusedDay) {
            return _buildCalendarDay(day);
          },
          selectedBuilder: (context, day, focusedDay) {
            return _buildSelectedCalendarDay(day);
          },
          todayBuilder: (context, day, focusedDay) {
            return _buildTodayCalendarDay(day);
          },
          outsideBuilder: (context, day, focusedDay) {
            return _buildOutsideCalendarDay(day);
          },
        ),
      ),
    );
  }

  // Individual calendar day widget
  Widget _buildCalendarDay(DateTime day) {
    return Container(
      width: 40.92,
      height: 40.92,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.lightGray,
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: const TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // Selected calendar day widget
  Widget _buildSelectedCalendarDay(DateTime day) {
    return Container(
      width: screenWidth,
      height: screenHeight5,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            AppColors.secondary,
            AppColors.blueShade.withOpacity(0.5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.018,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Today calendar day widget
  Widget _buildTodayCalendarDay(DateTime day) {
    return Container(
      width: 44,
      height: 40.92,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [AppColors.secondary, AppColors.blueShade.withOpacity(0.5)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Outside calendar day widget
  Widget _buildOutsideCalendarDay(DateTime day) {
    return Container(
      width: 40.92,
      height: 40.92,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: const TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w700,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  // Edit row widget
  Widget _buildEditRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Edit',
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: screenHeight * 0.016,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary,
                ),
          ),
        ),
        kWidth(0.01),
        const Icon(
          Icons.edit,
          color: AppColors.blueShade,
        ),
      ],
    );
  }

  // Appointment container widget
  Widget _buildAppointmentContainer(BuildContext context) {
    return Container(
      height: screenHeight * 0.18,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: AppColors.darkGray.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.08,
                  backgroundImage:
                      const AssetImage('assets/images/splash.jpeg'),
                ),
                kWidth(0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wade Warren',
                      style: GoogleFonts.poppins(
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontSize: screenHeight * 0.016,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                    Text(
                      '8101234567',
                      style: GoogleFonts.poppins(
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontSize: screenHeight * 0.014,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.darkGray,
                                ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.delete_outline_outlined,
                  color: AppColors.danger,
                ),
              ],
            ),
            kHeight(0.02), // Added space between rows
            Row(
              children: [
                const Icon(Icons.calendar_month_outlined),
                kWidth(0.04),
                Text(
                  '11.12.2024 - 12.12.2024',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: screenHeight * 0.016,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
